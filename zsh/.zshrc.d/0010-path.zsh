# Ensure custom user paths are included
typeset -U PATH
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"
[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"

# Setup Nix
if [[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi
export XDG_DATA_DIRS="$HOME/.nix-profile/share:$HOME/.share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
