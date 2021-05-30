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

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Automatically trim long paths in the prompt
PROMPT_DIRTRIM=3

## Readline bindings ##

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

# Suffix each returned file completion with a character denoting its type, in a similar way to 'ls' with -F
bind "set visible-stats on"

# Display common prefix of set of possible completions using a different color
bind "set colored-completion-prefix on"

# Display possible completions using different colors to indicate their file type
bind "set colored-stats on"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:ll:bg:fg:history:clear:dir"

# Save multi-line commands as one command
shopt -s cmdhist

# use readline on history
shopt -s histreedit

# load history line onto readline buffer for editing
shopt -s histverify

# save history with newlines instead of ; where possible
shopt -s lithist

# append to the history file, don't overwrite it
shopt -s histappend

## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
shopt -s autocd 2>/dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2>/dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2>/dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projec
CDPATH="."

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

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
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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
alias dir='ls -AlF --group-directories-first --human-readable'
alias :q='exit'
alias history='history | less'
alias ncdu='ncdu --color dark'
alias prd='cd /d/Data/Projects'
alias ghd='cd /d/Data/GitHub'
alias acd='cd /d/Data/Documents/Academics/Semester\ 6'

# Change to a safe location
startpath=$(pwd)
[[ $startpath == '/d/Data/Projects/Scripts' || $startpath == '/c/Program Files/WindowsApps/Microsoft.WindowsTerminal_1.4.3243.0_x64__8wekyb3d8bbwe' ]] && cd

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
[ -f ~/.local/share/fzf/key-bindings.bash ] && . ~/.local/share/fzf/key-bindings.bash || true
