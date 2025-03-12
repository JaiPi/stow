# Include the directory in your $fpath if ~/.zsh/zsh-completions exists
if [[ -d ~/.zsh/zsh-completions/src ]]; then
    fpath=(~/.zsh/zsh-completions/src $fpath)
fi