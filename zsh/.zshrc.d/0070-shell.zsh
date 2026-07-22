# ========================
# Shell Behavior Tweaks
# ========================

setopt nomatch         # Avoid errors for unmatched wildcards
setopt notify          # Notify when background jobs finish

unsetopt autocd        # Prevent accidental directory switching
unsetopt beep          # Disable system beep on errors
unsetopt extendedglob  # Disable advanced pattern matching (if not needed)

# Directory stack: every `cd` is remembered; jump back with `cd -<N>` / `dirs -v`
setopt AUTO_PUSHD          # Push visited dirs onto the stack automatically
setopt PUSHD_SILENT        # Don't print the stack after each pushd/popd
setopt PUSHD_IGNORE_DUPS   # Keep the stack free of duplicate entries

setopt INTERACTIVE_COMMENTS  # Allow `#` comments on the interactive command line
