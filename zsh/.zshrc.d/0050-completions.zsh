# ========================
# Zsh Completion Setup
# ========================

# Cache directory for tool-generated completion functions, added to fpath so
# compinit can pick them up. This avoids spawning a subprocess per tool on
# every shell startup (the old `source <(tool completion zsh)` pattern).
ZSH_COMPCACHE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions"
[[ -d "$ZSH_COMPCACHE" ]] || mkdir -p "$ZSH_COMPCACHE"
fpath=("$ZSH_COMPCACHE" $fpath)

# NOTE: zsh-completions is loaded synchronously in 0045-zinit.zsh, which adds its
# `src/` dir to fpath *before* this file runs — so compinit below picks it up
# with no manual registration needed.

# Map: tool -> subcommand that prints a zsh completion script to stdout.
typeset -A COMP_GENERATORS=(
    kubectl        "kubectl completion zsh"
    minikube       "minikube completion zsh"
    helm           "helm completion zsh"
    terraform-docs "terraform-docs completion zsh"
    starship       "starship completions zsh"
    uv             "uv generate-shell-completion zsh"
)

# (Re)generate a cache file when it is missing/empty or older than the tool
# binary (so upgrades refresh completions). Track whether anything changed so
# compinit can do a full rebuild instead of using the cached dump.
_comp_regenerated=0
for tool gen in ${(kv)COMP_GENERATORS}; do
    cmd=${gen%% *}
    command -v "$cmd" &>/dev/null || continue
    cache_file="$ZSH_COMPCACHE/_$tool"
    if [[ ! -s "$cache_file" || "$commands[$cmd]" -nt "$cache_file" ]]; then
        if eval "$gen" > "$cache_file" 2>/dev/null; then
            _comp_regenerated=1
        else
            rm -f "$cache_file"
        fi
    fi
done
unset tool gen cmd cache_file COMP_GENERATORS

# Load Zsh completion system. Rebuild the dump when it is missing, stale
# (>24h), or a completion file was just regenerated; otherwise use the fast
# cached path (`-C` skips the security/freshness scan).
autoload -Uz compinit
_zdump="${ZDOTDIR:-$HOME}/.zcompdump"
_comp_full=1
if [[ -f "$_zdump" && $_comp_regenerated -eq 0 ]]; then
    _comp_full=0
    for _f in ${_zdump}(Nmh+24); do _comp_full=1; done
fi
if (( _comp_full )); then
    compinit -d "$_zdump"
else
    compinit -C -d "$_zdump"
fi
unset _zdump _comp_full _comp_regenerated _f

# Enable Bash-style completion (some tools ship bash completions only)
autoload -Uz bashcompinit && bashcompinit

# Register zinit's own completion (needs the `_comps` table that compinit just built)
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# NOTE: nvm is handled by the OMZP::nvm plugin (see 0045-zinit.zsh / 0110-zstyle.zsh),
# which lazy-loads nvm and its bash_completion on first use. No manual sourcing here.
