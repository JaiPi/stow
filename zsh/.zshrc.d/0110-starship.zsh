# Load starship prompt configuration if /usr/local/bin/starship exists
[[ -x /usr/local/bin/starship ]] &&
eval "$(starship init zsh)"