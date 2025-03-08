autoload -Uz compinit && compinit -C  # Faster startup
autoload -Uz bashcompinit && bashcompinit  # Enable Bash-style completion

# Enable Kubernetes, Minikube, Helm, Terraform-docs completion
if command -v kubectl &>/dev/null; then
    source <(kubectl completion zsh)
fi
if command -v minikube &>/dev/null; then
    source <(minikube completion zsh)
fi
if command -v helm &>/dev/null; then
    source <(helm completion zsh)
fi
if command -v terraform-docs &>/dev/null; then
    source <(terraform-docs completion zsh)
fi
