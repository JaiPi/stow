# ========================
# Starship Prompt Setup
# ========================

# Load Starship if installed. The init script is cached to a file (like the
# tool completions in 0050) so startup avoids a subprocess; it regenerates
# whenever the starship binary is newer than the cache (i.e. after upgrades).
if command -v starship &>/dev/null; then
    _starship_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/starship-init.zsh"
    if [[ ! -s "$_starship_cache" || "$commands[starship]" -nt "$_starship_cache" ]]; then
        mkdir -p "${_starship_cache:h}"
        starship init zsh --print-full-init > "$_starship_cache" 2>/dev/null || rm -f "$_starship_cache"
    fi
    [[ -s "$_starship_cache" ]] && source "$_starship_cache"
    unset _starship_cache
fi
