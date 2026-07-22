# ========================
# ~/.zprofile — sourced once for LOGIN shells (after ~/.zshenv, before ~/.zshrc)
# Heavier one-time setup that child shells inherit via the environment.
# ========================

# Setup Nix Package Manager
if [[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
elif [[ -f "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]]; then
    source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
fi

# Ensure XDG_DATA_DIRS includes Nix paths correctly
export XDG_DATA_DIRS="${HOME}/.nix-profile/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
