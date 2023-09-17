#!/usr/bin/env bash

[[ -f /usr/bin/msys-2.0.dll ]] || [[ -f /bin/cygwin1.dll ]] && exit

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

mkdir -p ~/.config/ncspot
ln -sf $DOT_DIR/ncspot/config.toml ~/.config/ncspot/

ln -sf $DOT_DIR/nvim ~/.config/nvim
