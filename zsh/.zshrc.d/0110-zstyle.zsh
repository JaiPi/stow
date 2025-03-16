# ========================
# Zsh Completion Enhancements
# ========================

# Disable the completion menu (only show when pressing Tab twice)
zstyle ':completion:*' menu no

# Use `LS_COLORS` for completion colors (only if LS_COLORS is set)
if [[ -n $LS_COLORS ]]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# Show a warning message in red when no matches are found
zstyle ':completion:*:warnings' format "$fg[red]No matches$reset_color"

# Enable smarter case-insensitive matching
zstyle ':completion:*' matcher-list \
    'm:{a-zA-Z}={A-Za-z}' \
    'r:|[._-]=**'  # Also match `.` and `-` when completing words

# ========================
# fzf-tab Enhancements
# ========================

# Show a preview when using `cd`
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -A --color=auto --group-directories-first $realpath'

# Better ls preview in fzf-tab
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'ls -A --color=auto  --group-directories-first $realpath'

# ========================
# Oh-My-Zsh Plugin: Alias Finder
# ========================

# Enable alias-finder features
zstyle ':omz:plugins:alias-finder' autoload yes  # Load automatically
zstyle ':omz:plugins:alias-finder' exact yes     # Match exact aliases
zstyle ':omz:plugins:alias-finder' cheaper yes   # Reduce performance impact
