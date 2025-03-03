# Check if bash-completion is installed
if [ -f /usr/share/bash-completion/bash_completion ] || [ -f /etc/bash_completion ]; then

    # Enable kubectl completion if kubectl is installed
    if command -v kubectl &> /dev/null; then
        source <(kubectl completion bash)
    fi

    # Enable minikube completion if minikube is installed
    if command -v minikube &> /dev/null; then
        source <(minikube completion bash)
    fi

    # Enable helm completion if helm is installed
    if command -v helm &> /dev/null; then
        source <(helm completion bash)
    fi

    # Enable terraform-docs completion if terraform-docs is installed
    if command -v terraform-docs &> /dev/null; then
        source <(terraform-docs completion bash)
    fi

fi

