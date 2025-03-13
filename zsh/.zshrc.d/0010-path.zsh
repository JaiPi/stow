# ========================
# Custom User Paths
# ========================

typeset -U PATH  # Ensure unique entries in PATH

# Define user directories to add to PATH
USER_PATHS=(
  "$HOME/bin"
  "$HOME/.local/bin"
)

# Add directories only if they exist
for dir in $USER_PATHS; do
    [[ -d "$dir" ]] && PATH="$dir:$PATH"
done

export PATH  # Ensure PATH updates correctly

# ========================
# Setup Nix Package Manager
# ========================

if [[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
elif [[ -f "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]]; then
    source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
fi

# Ensure XDG_DATA_DIRS includes Nix paths correctly
export XDG_DATA_DIRS="${HOME}/.nix-profile/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
