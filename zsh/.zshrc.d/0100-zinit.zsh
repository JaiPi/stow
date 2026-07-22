# ========================
# Zinit Plugin Manager Setup
# ========================

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

# Enable Zinit completions
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# ========================
# Zsh Plugins with Zinit
# ========================

# All plugins load via turbo mode (`wait lucid`) after the first prompt, in the
# order declared. Order matters: syntax-highlighting must be sourced LAST so it
# wraps every other widget correctly.

# Autosuggestions — under turbo, needs an explicit start since precmd already ran
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Extra completion definitions — `blockf` stops the plugin from touching fpath;
# its dir is registered pre-compinit in 0050-completions.zsh instead.
zinit ice wait lucid blockf
zinit light zsh-users/zsh-completions

# fzf-tab — replaces the completion menu with an fzf picker
zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# Syntax highlighting — MUST be last. (Swap to zdharma-continuum/fast-syntax-highlighting
# for a faster drop-in if desired.)
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

# Load useful Oh-My-Zsh plugin snippets
zinit snippet OMZP::alias-finder
zinit snippet OMZP::nvm
