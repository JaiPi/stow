autoload -Uz colors && colors

# Detect if the terminal supports color
case "$TERM" in
    xterm-color | *-256color) color_prompt=yes ;;
esac

# Uncomment this if you always want color:
# force_color_prompt=yes

if [[ -n "$force_color_prompt" ]]; then
    if command -v tput &>/dev/null && tput setaf 1 &>/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Configure prompt settings
PROMPT_ALTERNATIVE="twoline"
NEWLINE_BEFORE_PROMPT="yes"

# Define prompt colors
prompt_symbol="🐧"
prompt_color="%F{green}"
info_color="%F{blue}"

# Change colors for root user
if [[ $EUID -eq 0 ]]; then
    prompt_symbol="💀"
    prompt_color="%F{brightcyan}"
    info_color="%F{brightred}"
fi

# Set prompt format
case "$PROMPT_ALTERNATIVE" in
    twoline)
        PROMPT="${prompt_color}┌──(${info_color}%n${prompt_symbol}%m${prompt_color})-[%B%~%b]"$'\n'"${prompt_color}└─${info_color}$%f "
        ;;
    oneline)
        PROMPT="%B${info_color}%n@%m%f:%B%~%b ${prompt_color}$%f "
        ;;
    backtrack)
        PROMPT="%B%F{red}%n@%m%f%F{blue}:%~%f $%b "
        ;;
esac

# Reset colors
unset prompt_color info_color prompt_symbol

# Add newline before prompt if enabled
[[ "$NEWLINE_BEFORE_PROMPT" == "yes" ]] && PROMPT=$'\n'"$PROMPT"

# Set terminal title (equivalent to Bash PS1 behavior)
case "$TERM" in
    xterm* | rxvt* | Eterm | aterm | kterm | gnome* | alacritty)
        precmd() { print -Pn "\e]0;%n@%m: %~\a" }
        ;;
esac
