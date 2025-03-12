
# Do menu-driven completion.
zstyle ':completion:*' menu no

# Color completion for some things.
# http://linuxshellaccount.blogspot.com/2008/12/color-completion-using-zsh-modules-on.html
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# formatting and messages
# http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

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
