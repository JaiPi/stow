# ========================
# Aliases Configuration
# ========================

# ls aliases
alias ll='ls -l'
alias la='ls -lA'
alias l='ls -CF'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Kubernetes aliases
alias k='kubectl'
alias kg='kubectl get'
alias kds='kubectl describe'
alias kl='kubectl logs'
alias kx='kubectl exec -it'

# Terraform aliases
TF_COMMANDS=(
  "tfi:init"
  "tfp:plan"
  "tfa:apply"
  "tfc:console"
  "tff:fmt -recursive"
  "tfw:workspace"
  "tfs:state"
)

alias tf='terraform'
for cmd in "${TF_COMMANDS[@]}"; do
  alias "${cmd%%:*}"="tf ${cmd#*:}"
done
alias tfd='terraform-docs .'

# Miscellaneous
alias cl='clear'
alias hg='history | grep '
alias eza='exa --icons --group-directories-first'  # Alternative to ls if exa is installed
