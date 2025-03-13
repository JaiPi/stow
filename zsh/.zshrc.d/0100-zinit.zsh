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

# Optimize plugin loading with `zinit ice`
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait lucid
zinit light zsh-users/zsh-completions

zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light Aloxaf/fzf-tab  # Improves tab completion

# Load useful Oh-My-Zsh plugin snippets
zinit snippet OMZP::alias-finder
