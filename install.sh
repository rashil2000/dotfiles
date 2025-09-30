#!/usr/bin/env bash

[[ -f /usr/bin/msys-2.0.dll ]] || [[ -f /bin/cygwin1.dll ]] && exit

mkdir -p ~/.ssh
curl -fsSL https://github.com/rashil2000.keys >> ~/.ssh/authorized_keys

if grep -qi ubuntu /etc/os-release; then
  sudo apt update
  sudo apt install git make gawk fzf ripgrep fd-find bat vifm tmux apt-transport-https software-properties-common

  if ! command -v pwsh &> /dev/null; then
    curl -fsSL https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -o packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb
    sudo apt update
    sudo apt install powershell
    # Once this is done, run `Install-Module CompletionPredictor, Terminal-Icons, npm-completion, posh-cargo, posh-git, PsFzf` in pwsh
  fi
fi

DOT_DIR=~/GitHub/rashil2000/dotfiles

mkdir -p $DOT_DIR
git clone https://github.com/rashil2000/dotfiles $DOT_DIR
mkdir -p ~/.config
mkdir -p ~/.local/share/bash
ln -sf $DOT_DIR/.inputrc ~/

ln -sf $DOT_DIR/bash/.bashrc ~/
\cp -f $DOT_DIR/bash/.profile ~/
git clone --recursive https://github.com/akinomyoga/ble.sh ~/GitHub/akinomyoga/ble.sh
pushd ~/GitHub/akinomyoga/ble.sh
make
popd
git clone https://github.com/junegunn/fzf ~/GitHub/junegunn/fzf

mkdir -p ~/.local/bin
ln -sf $DOT_DIR/starship/starship.toml ~/.config/
curl -fsSL https://starship.rs/install.sh | sh -s -- -b ~/.local/bin -y
~/.local/bin/starship init bash --print-full-init > ~/.local/share/starship.bash
~/.local/bin/starship init powershell --print-full-init > ~/.local/share/starship.ps1

mkdir -p ~/.config/git
ln -sf $DOT_DIR/git/config ~/.config/git/

mkdir -p ~/.config/tmux
ln -sf $DOT_DIR/tmux/tmux.conf ~/.config/tmux/

mkdir -p ~/.config/powershell
ln -sf $DOT_DIR/pwsh/Microsoft.PowerShell_profile.ps1 ~/.config/powershell/
\cp -f $DOT_DIR/pwsh/profile.ps1 ~/.config/powershell/

mkdir -p ~/.config/vifm
ln -sf $DOT_DIR/vifm/vifmrc ~/.config/vifm/

ln -sf $DOT_DIR/bat ~/.config/bat

mkdir -p ~/.config/bottom
ln -sf $DOT_DIR/bottom/bottom.toml ~/.config/bottom/

mkdir -p ~/.config/spotify-player
ln -sf $DOT_DIR/spotify-player/app.toml ~/.config/spotify-player

ln -sf $DOT_DIR/wezterm ~/.config/wezterm

ln -sf $DOT_DIR/nvim ~/.config/nvim
