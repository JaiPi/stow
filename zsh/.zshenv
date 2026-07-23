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

# Expose nvm's default node on PATH without loading nvm itself (nvm stays
# lazy for startup speed — see 0044-zstyle/0045-zinit). Child processes such
# as editors and MCP servers spawning `npx` need real binaries on PATH; the
# interactive lazy-load stubs are shell functions they cannot see.
if [[ -d "$HOME/.nvm/versions/node" ]]; then
    _nvm_alias=
    [[ -r "$HOME/.nvm/alias/default" ]] && _nvm_alias=$(<"$HOME/.nvm/alias/default")
    # Match the default alias (e.g. "20" -> newest v20.x); fall back to newest installed
    _nvm_dirs=("$HOME/.nvm/versions/node/"v${_nvm_alias#v}*(/Nn))
    (( $#_nvm_dirs )) || _nvm_dirs=("$HOME/.nvm/versions/node/"v*(/Nn))
    (( $#_nvm_dirs )) && path=("${_nvm_dirs[-1]}/bin" $path)
    unset _nvm_alias _nvm_dirs
fi

export PATH
