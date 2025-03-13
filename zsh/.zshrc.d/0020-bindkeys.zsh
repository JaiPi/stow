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

# Move Cursor by Words (Alt + ←/→) - Covers multiple terminal types
bindkey '^[[1;3D' backward-word  
bindkey '^[[1;3C' forward-word

# Esc Clears the Current Line
bindkey '\e' kill-whole-line
