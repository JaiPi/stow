zstyle ':completion:*' menu no
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:warnings' format "$fg[red]No matches$reset_color"

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default