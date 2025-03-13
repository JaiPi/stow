autoload -Uz colors && colors

# Set terminal title (equivalent to Bash PS1 behavior)
case "$TERM" in
    xterm* | rxvt* | Eterm | aterm | kterm | gnome* | alacritty)
        precmd() { print -Pn "\e]0;%n@%m: %~\a" }
        ;;
esac
