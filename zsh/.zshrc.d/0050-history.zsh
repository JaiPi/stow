# ========================
# Zsh History Settings
# ========================

HISTSIZE=10000               # Number of commands in memory
SAVEHIST=$HISTSIZE           # Number of commands stored in history file
HISTFILE="$HOME/.zsh_history" # History file location
HISTDUP=erase                # Remove duplicates

# Remove timestamps from history
unsetopt EXTENDED_HISTORY    # Prevents Zsh from storing timestamps

# Zsh history behavior
setopt APPEND_HISTORY         # Append history instead of overwriting
setopt INC_APPEND_HISTORY     # Save history immediately (not at end of session)
setopt SHARE_HISTORY          # Share history across multiple sessions

# Avoid duplicate commands
setopt HIST_FIND_NO_DUPS      # Do not display duplicates in search results
setopt HIST_IGNORE_DUPS       # Ignore duplicate commands in the current session
setopt HIST_IGNORE_ALL_DUPS   # Remove previous duplicates in history
setopt HIST_SAVE_NO_DUPS      # Never save duplicate commands
setopt HIST_EXPIRE_DUPS_FIRST # Delete the oldest duplicate first

# Improve history behavior
setopt HIST_IGNORE_SPACE      # Ignore commands starting with a space
setopt HIST_REDUCE_BLANKS     # Remove extra spaces before saving a command
setopt HIST_VERIFY            # Show command before running when recalled from history
setopt HIST_BEEP              # Disable beep sound when searching history

# Improve `fc` (Fix Command) behavior
setopt HIST_ALLOW_CLOBBER     # Allows history expansion with `>` and `>>`
