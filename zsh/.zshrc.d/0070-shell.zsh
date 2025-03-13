# ========================
# Shell Behavior Tweaks
# ========================

setopt nomatch         # Avoid errors for unmatched wildcards
setopt notify          # Notify when background jobs finish

unsetopt autocd        # Prevent accidental directory switching
unsetopt beep          # Disable system beep on errors
unsetopt extendedglob  # Disable advanced pattern matching (if not needed)