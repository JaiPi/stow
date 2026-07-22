# ========================
# fzf Configuration
# ========================

# Only configure fzf if it is installed
if command -v fzf &>/dev/null; then

    # Default look & feel
    export FZF_DEFAULT_OPTS="
        --height 40%
        --reverse
        --border
    "

    # Prefer fd/rg for the file/dir search commands if available (faster, respects .gitignore)
    if command -v fd &>/dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    fi

    # Key bindings (Ctrl-R history, Ctrl-T files, Alt-C cd) + fuzzy completion.
    # fzf 0.48+ ships `fzf --zsh`; older Debian packages ship the scripts on disk.
    if fzf --zsh &>/dev/null; then
        source <(fzf --zsh)
    else
        # Older fzf scripts snapshot/restore *all* shell options on load, which
        # noisily warns about the read-only `zle` option — filter just that line.
        for _fzf_f in \
            /usr/share/doc/fzf/examples/key-bindings.zsh \
            /usr/share/doc/fzf/examples/completion.zsh \
            /usr/share/fzf/key-bindings.zsh \
            /usr/share/fzf/completion.zsh; do
            [[ -r "$_fzf_f" ]] && source "$_fzf_f" 2> >(grep -v "can't change option: zle" >&2)
        done
        unset _fzf_f
    fi

fi
