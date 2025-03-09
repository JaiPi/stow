# Load additional configuration files from ~/.zshrc.d/
if [[ -d "$HOME/.zshrc.d" ]]; then
    for rc in "$HOME/.zshrc.d/"*.zsh; do
        [[ -f "$rc" ]] && source "$rc"
    done
fi
unset rc

eval "$(starship init zsh)"

# Lines configured by zsh-newuser-install
setopt nomatch notify
unsetopt autocd beep extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jaipi/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
