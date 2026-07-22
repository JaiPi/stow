# ========================
# Zsh History Settings
# ========================

HISTSIZE=10000               # Number of commands in memory
SAVEHIST=$HISTSIZE           # Number of commands stored in history file
HISTFILE="$HOME/.zsh_history" # History file location
HISTDUP=erase                # Remove duplicates

# Store timestamps in history (auditable history; enables time-based fc/search)
setopt EXTENDED_HISTORY

# Zsh history behavior
setopt APPEND_HISTORY         # Append history instead of overwriting
setopt SHARE_HISTORY          # Share history across sessions (implies INC_APPEND_HISTORY)

# Avoid duplicate commands
setopt HIST_FIND_NO_DUPS      # Do not display duplicates in search results
setopt HIST_IGNORE_ALL_DUPS   # Remove previous duplicates in history (supersedes HIST_IGNORE_DUPS)
setopt HIST_SAVE_NO_DUPS      # Never save duplicate commands
setopt HIST_EXPIRE_DUPS_FIRST # Delete the oldest duplicate first

# Improve history behavior
setopt HIST_IGNORE_SPACE      # Ignore commands starting with a space
setopt HIST_REDUCE_BLANKS     # Remove extra spaces before saving a command
setopt HIST_VERIFY            # Show command before running when recalled from history
unsetopt HIST_BEEP            # No beep when cycling past the end of history

# Improve `fc` (Fix Command) behavior
setopt HIST_ALLOW_CLOBBER     # Allows history expansion with `>` and `>>`
