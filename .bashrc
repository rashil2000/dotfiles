# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*)
  # Initialize ble.sh
  if [ -f /d/Data/GitHub/akinomyoga/ble.sh/out/ble.sh ]; then
    . /d/Data/GitHub/akinomyoga/ble.sh/out/ble.sh --noattach
    bleopt history_share=1
    ble-bind -f up 'history-search-backward hide-status:immediate-accept:point=end'
    ble-bind -f down 'history-search-forward hide-status:immediate-accept:point=end'
  fi
  ;;
*)
  return
  ;;
esac

# Automatically trim long paths in the prompt
PROMPT_DIRTRIM=3

# Set history lengths
HISTSIZE=10000
HISTFILESIZE=20000
# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"
# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:ll:bg:fg:history:clear:dir"

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# cmdhist      - save multi-line commands as one command
# histreedit   - use readline on history
# histverify   - load history line onto readline buffer for editing
# lithist      - save history with newlines instead of ; where possible
# histappend   - append to the history file, don't overwrite it
# autocd       - prepend cd to directory names automatically
# dirspell     - correct spelling errors during tab-completion
# cdspell      - correct spelling errors in arguments supplied to cd
# nocaseglob   - case-insensitive globbing (used in pathname expansion)
# cdable_vars  - This allows you to bookmark your favorite places across the file system
#                Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
# checkwinsize - check the window size after each command and, if necessary,
#                update the values of LINES and COLUMNS.
# globstar     - If set, the pattern "**" used in a pathname expansion context will
#                match all files and zero or more directories and subdirectories.
shopt -s cmdhist histreedit histverify lithist histappend autocd dirspell cdspell nocaseglob cdable_vars checkwinsize globstar 2>/dev/null

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r /etc/DIR_COLORS && eval "$(dircolors -b /etc/DIR_COLORS)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias diff='diff --color=auto'
  alias ip='ip --color=auto'

  export LESS_TERMCAP_mb=$'\E[1;31m'  # begin blink
  export LESS_TERMCAP_md=$'\E[1;36m'  # begin bold
  export LESS_TERMCAP_me=$'\E[0m'     # reset bold/blink
  export LESS_TERMCAP_so=$'\E[01;33m' # begin reverse video
  export LESS_TERMCAP_se=$'\E[0m'     # reset reverse video
  export LESS_TERMCAP_us=$'\E[1;32m'  # begin underline
  export LESS_TERMCAP_ue=$'\E[0m'     # reset underline

  # colored GCC warnings and errors
  export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# An "alert" alias for long running commands.  Use like so: $ sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Custom Aliases
alias dir='exa -la --icons --git --group-directories-first'
alias :q='exit'
alias prd='cd /d/Data/Projects'
alias ghd='cd /d/Data/GitHub'
alias acd='cd /d/Data/Documents/Academics/Semester\ 6'

# Change to a safe location
startpath=$(pwd)
[[ $startpath == '/d/Data/Projects/Scripts' || $startpath == '/c/Windows/System32' ]] && cd

# Enable Starship prompt
[ -f ~/.local/share/starship.bash ] && . ~/.local/share/starship.bash || true

# Startup info
read msyskernelname msyskernelrelease <<<$(uname -sr)
echo "Microsoft Windows [$msyskernelname]"
echo "(c) Minimal System 2 - $msyskernelrelease"
# if [[ -v __shell_start ]]; then
#   echo -e "\nLoading personal and system profiles took $(($(date +%s%3N) - __shell_start))ms."
# fi

# Attach to ble.sh
[[ ${BLE_VERSION-} ]] && ble-attach

# FZF Key bindings
export FZF_DEFAULT_OPTS="--exact --no-sort --reverse --cycle"
[ -f ~/.local/share/fzf/key-bindings.bash ] && . ~/.local/share/fzf/key-bindings.bash || true

# Node Version Switcher
[ -f ~/Scoop/apps/nvs/current/nvs.sh ] && . ~/Scoop/apps/nvs/current/nvs.sh || true
