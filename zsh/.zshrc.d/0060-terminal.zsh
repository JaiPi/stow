# ========================
# Terminal Settings
# ========================

case "$TERM" in
    xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty|konsole*|screen*|tmux*)
        precmd() {
            print -Pn "\e]0;%n@%m: %~\a"
        }
        preexec() {
            print -Pn "\e]0;%n@%m: %~ | Running: $1\a"
        }
        ;;
esac
