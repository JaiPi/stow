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

fi

