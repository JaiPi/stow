# ========================
# Zsh Keyboard Shortcuts
# ========================

# Enable Emacs-style keybindings
bindkey -e  

# History Search (Smart Up/Down)
bindkey '^P' history-search-backward  
bindkey '^N' history-search-forward  

# Editing Shortcuts
bindkey '^U' backward-kill-line   # Ctrl+U: Delete everything before cursor
bindkey '^K' kill-line            # Ctrl+K: Delete everything after cursor
bindkey '^W' backward-kill-word   # Ctrl+W: Delete last word

# Move Cursor by Words (Ctrl + ←/→) - Covers multiple terminal types
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Insert last word of previous command (Alt+.), cycles through history on repeat
bindkey '^[.' insert-last-word

# Home / End / Delete (common terminal escape sequences)
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char
