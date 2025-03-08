if [[ -x /usr/bin/dircolors ]]; then
    eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:"  # Fix ls color for folders with 777 permissions

    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    # Less colors
    export LESS_TERMCAP_mb=$'\e[1;31m'
    export LESS_TERMCAP_md=$'\e[1;36m'
    export LESS_TERMCAP_me=$'\e[0m'
    export LESS_TERMCAP_so=$'\e[01;33m'
    export LESS_TERMCAP_se=$'\e[0m'
    export LESS_TERMCAP_us=$'\e[1;32m'
    export LESS_TERMCAP_ue=$'\e[0m'
fi
