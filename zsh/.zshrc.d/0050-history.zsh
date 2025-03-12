HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTFILE="$HOME/.zsh_history"
HISTDUP=erase

setopt APPEND_HISTORY        # Append instead of overwriting
setopt INC_APPEND_HISTORY    # Write to history immediately
setopt SHARE_HISTORY         # Share history across sessions
setopt HIST_IGNORE_DUPS      # Ignore duplicate commands
setopt HIST_IGNORE_SPACE     # Ignore commands starting with a space
setopt HIST_VERIFY           # Show command before executing with `!`
setopt HIST_EXPIRE_DUPS_FIRST # Delete oldest duplicate first
setopt HIST_FIND_NO_DUPS     # Do not display duplicates when searching
setopt HIST_SAVE_NO_DUPS     # Do not save duplicates in history
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks before saving