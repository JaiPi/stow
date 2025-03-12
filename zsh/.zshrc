# Load configuration files from ~/.zshrc.d/
if [[ -d "$HOME/.zshrc.d" ]]; then
    for rc in "$HOME/.zshrc.d/"*.zsh; do
        [[ -f "$rc" ]] && source "$rc"
    done
fi
unset rc