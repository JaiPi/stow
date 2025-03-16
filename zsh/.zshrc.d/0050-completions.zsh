# ========================
# Zsh Completion Setup
# ========================

# Load Zsh completion system (faster startup with caching)
autoload -Uz compinit && compinit -C

# Enable Bash-style completion 
autoload -Uz bashcompinit && bashcompinit

# Define CLI tools that support Zsh completion
CLI_TOOLS=(
    kubectl
    minikube
    helm
    terraform-docs
)

# Dynamically load completions for available tools
for cmd in "${CLI_TOOLS[@]}"; do
    if command -v "$cmd" &>/dev/null; then
        source <("$cmd" completion zsh)
    fi
done

# Load Starship completions
if command -v starship &>/dev/null; then
    source <(starship completions zsh)
fi

# # Source Terraform completion
# if command -v terraform &>/dev/null; then
#     complete -o nospace -C "$(command -v terraform)" terraform
# fi
