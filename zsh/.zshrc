# ========================
# Load Configuration Files from ~/.zshrc.d/
# ========================

CONFIG_DIR="$HOME/.zshrc.d"

if [[ -d "$CONFIG_DIR" ]]; then
    for rc in "$CONFIG_DIR"/*.zsh; do
        [[ -r "$rc" ]] && source "$rc"
    done
fi

unset rc CONFIG_DIR  # Clean up variables after use
