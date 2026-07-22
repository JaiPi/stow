# ========================
# ~/.zshenv — sourced by EVERY zsh (interactive, non-interactive, scripts)
# Keep this minimal, fast, and free of side effects. Interactive-only setup
# belongs in ~/.zshrc.d/, login-only setup in ~/.zprofile.
# ========================

# Custom user paths (deduped). Prepend only if the directory exists.
typeset -U path PATH
for dir in "$HOME/bin" "$HOME/.local/bin"; do
    [[ -d "$dir" ]] && path=("$dir" $path)
done
export PATH
