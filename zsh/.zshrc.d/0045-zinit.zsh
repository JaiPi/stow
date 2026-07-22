# ========================
# Zinit Plugin Manager Setup
# ========================
# Runs BEFORE 0050-completions.zsh so that completion-providing plugins are in
# fpath when `compinit` runs there.

# Define Zinit home directory
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Ensure Zinit is installed
if [[ ! -d "${ZINIT_HOME}" ]]; then
    echo "🔧 Installing Zinit..."
    mkdir -p "$(dirname "$ZINIT_HOME")"
    if git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"; then
        echo "✅ Zinit installed successfully."
    else
        echo "❌ Failed to install Zinit!" >&2
        return 1
    fi
fi

# Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# ========================
# Completion source — loaded SYNCHRONOUSLY (no `wait`) so its `src/` dir is on
# fpath before compinit runs in 0050. No `blockf`: that would stop the plugin
# from adding itself to fpath, which is exactly what we need here.
# ========================
zinit light zsh-users/zsh-completions

# ========================
# Deferred (turbo) plugins — loaded after the first prompt, in declaration
# order. Order matters: the syntax highlighter must come before
# history-substring-search, and both after the widget-defining plugins.
# ========================

# Autosuggestions — under turbo, needs an explicit start since precmd already ran
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# fzf-tab — replaces the completion menu with an fzf picker
zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# Fast syntax highlighting — richer/faster drop-in; must load last among the
# widget-wrapping plugins.
zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

# History substring search — type a prefix then Up/Down to cycle matches. Loaded
# after the highlighter (per its docs); keys are bound via atload once the
# widgets exist. Complements the prefix ^P/^N binds in 0020-bindkeys.zsh.
zinit ice wait lucid atload'
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey "^[OA" history-substring-search-up
bindkey "^[OB" history-substring-search-down'
zinit light zsh-users/zsh-history-substring-search

# Load useful Oh-My-Zsh plugin snippets (deferred — their zstyle config is set
# in 0044-zstyle.zsh, which must already have run by load time)
zinit ice wait lucid
zinit snippet OMZP::alias-finder
zinit ice wait lucid
zinit snippet OMZP::nvm
