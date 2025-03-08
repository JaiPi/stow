HISTSIZE=50000
SAVEHIST=100000
HISTFILE="$HOME/.zsh_history"

setopt APPEND_HISTORY        # Append instead of overwriting
setopt INC_APPEND_HISTORY    # Write to history immediately
setopt SHARE_HISTORY         # Share history across sessions
setopt HIST_IGNORE_DUPS      # Ignore duplicate commands
setopt HIST_IGNORE_SPACE     # Ignore commands starting with a space
setopt HIST_VERIFY           # Show command before executing with `!`
setopt HIST_EXPIRE_DUPS_FIRST # Delete oldest duplicate first
