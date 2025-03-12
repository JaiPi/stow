# Load fzf-tab if ~/.zsh/fzf-tab exists
[[ -d ~/.zsh/fzf-tab ]] && 
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'