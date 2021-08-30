# ~/.zshrc file for zsh non-login shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[Z' undo                               # shift + tab undo last action

# better search defaults
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end  # up to search history
bindkey "^[[B" history-beginning-search-forward-end   # down to search history

# enable completion features
fpath=(~/GitHub/rashil2000/scripts/completions $fpath)    # User-defined completions
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu yes select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' fake-files   '/:c' '/:d'           # MSys2 Drives
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# history configurations
HISTFILE=~/.cache/.zsh_history
HISTSIZE=1000
SAVEHIST=10000
HISTORY_IGNORE="(exit|ls|pwd|bg|fg|history|clear|dir)"

# some shell options
# hist_expire_dups_first : delete duplicates first when HISTFILE size exceeds HISTSIZE
# hist_ignore_dups       : ignore duplicated commands history list
# hist_ignore_space      : ignore commands that start with space
# hist_verify            : show command with history expansion to user before running it
# share_history          : share command history data
# interactivecomments    : allow comments in interactive mode
# magicequalsubst        : enable filename expansion for arguments of the form ‘anything=expression’
# nonomatch              : hide error message if there is no match for the pattern
# notify                 : report the status of background jobs immediately
# numericglobsort        : sort filenames numerically when it makes sense
# promptsubst            : enable command substitution in prompt
setopt hist_expire_dups_first hist_ignore_dups hist_ignore_space hist_verify share_history interactivecomments magicequalsubst nonomatch notify numericglobsort promptsubst

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -A --color=auto'
    alias dir='dir -A --color=auto'
    alias vdir='vdir -A --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    # colored GCC warnings and errors
    export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
fi

# custom aliases
alias :q='exit'
alias dir='exa -la --icons --git --group-directories-first'
alias h='cd ~'
alias ghd='cd ~/GitHub'
alias acd='cd ~/Documents/Academics/Semester\ 6'
. ~/.nvs/nvs.sh 2>/dev/null || true
mkcd() { mkdir -p "$@" && cd "$@"; }
gccd() { git clone "git@github.com:$1/$2.git" && cd $2; }

# enable syntax-highlighting
if [ -f ~/GitHub/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    . ~/GitHub/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
fi

# enable auto-suggestions
if [ -f ~/GitHub/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . ~/GitHub/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    # https://github.com/zsh-users/zsh-autosuggestions/issues/619
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-beginning-search-backward-end history-beginning-search-forward-end)
fi

# enable Starship prompt
[ -f ~/.local/share/starship.zsh ] && . ~/.local/share/starship.zsh || true

# enable Fzf keybindings
[ -f ~/GitHub/junegunn/fzf/shell/key-bindings.zsh ] && . ~/GitHub/junegunn/fzf/shell/key-bindings.zsh || true

# startup info (Check if on MSys2)
if [ -f /usr/bin/msys-2.0.dll ]; then
    read msyskernelname msyskernelrelease <<< $(uname -sr)
    echo "Microsoft Windows [$msyskernelname]"
    echo "(c) Minimal System 2 - $msyskernelrelease"
fi
if [[ -v __shell_start ]]; then
  echo -e "\nLoading personal and system profiles took $((`date +%s%3N`-__shell_start))ms."
fi
