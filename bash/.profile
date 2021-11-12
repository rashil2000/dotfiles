# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export NVS_HOME="$HOME/.nvs"
[ -f "$NVS_HOME/nvs.sh" ] && . "$NVS_HOME/nvs.sh"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# man page colors
export LESS='--mouse'
export LESS="$HOME/.cache/lesshst"
export LESS_TERMCAP_mb=$'\E[1;31m'  # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'     # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'     # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'  # begin underline
export LESS_TERMCAP_ue=$'\E[0m'     # reset underline

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Some environment variables
export FZF_DEFAULT_OPTS='--exact --no-sort --reverse --cycle --height 40%'
export FZF_CTRL_T_COMMAND='fd -H -L -E .git -t f'
export FZF_ALT_C_COMMAND='fd -H -L -E .git -t d'
export FZF_CTRL_T_OPTS='--preview "bat --color=always --line-range=:500 {}"'
export FZF_ALT_C_OPTS='--preview "exa -a --icons --group-directories-first --color=always {}"'
