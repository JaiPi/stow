# ========================
# Color Support Configuration
# ========================

autoload -Uz colors && colors  # Enable color support

# Enable better ls colors (if dircolors is available)
if command -v dircolors &>/dev/null; then
    eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"

    # Custom LS_COLORS (Better visibility)
    export LS_COLORS="di=1;34:ln=36:so=1;35:pi=33:ex=1;32:bd=1;33;44:cd=1;33;44:su=1;37;41:sg=1;30;43:tw=1;30;42:ow=1;30;45:"

    # Enable colored output for common commands
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'
fi

# Better colors for less (pager)
export LESS_TERMCAP_mb=$'\e[1;31m'   # Blinking bold red
export LESS_TERMCAP_md=$'\e[1;34m'   # Bold blue (headers)
export LESS_TERMCAP_me=$'\e[0m'      # Reset
export LESS_TERMCAP_so=$'\e[01;43;30m' # Yellow background, black text (highlighted text)
export LESS_TERMCAP_se=$'\e[0m'      # Reset highlight
export LESS_TERMCAP_us=$'\e[1;32m'   # Underline green
export LESS_TERMCAP_ue=$'\e[0m'      # Reset underline

# Improve grep visibility
export GREP_COLORS='mt=1;37;41'  # Bold white text on red background for matches

# Enable better syntax highlighting for `bat`
export BAT_THEME="Dracula"

# Fix terminal output compatibility for colors
export TERM="xterm-256color"
