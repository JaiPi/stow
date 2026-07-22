# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal dotfiles repository managed with **GNU Stow**. Each top-level directory is a "package" whose internal path structure mirrors the layout under `$HOME`. Stow symlinks package contents into `$HOME`, so e.g. `zsh/.zshrc` becomes `~/.zshrc` and `bash/.bashrc.d/alias.bashrc` becomes `~/.bashrc.d/alias.bashrc`.

Packages: `aws`, `bash`, `claude`, `git`, `ssh`, `tfswitch`, `tmux`, `zsh`.

## Commands

Run from the repo root (`~/stow`), targeting `$HOME`:

```bash
stow <package>              # symlink a package into $HOME
stow -D <package>            # remove a package's symlinks
stow -R <package>            # restow (remove + re-apply, useful after editing a package's contents)
stow --simulate <package>    # dry run, prints what would happen without changing anything
stow bash zsh git            # multiple packages at once
```

There is no build, lint, or test suite — this is configuration, not code. The way to validate a change is `stow --simulate <package>` followed by actually stowing and starting a fresh shell (or `source`-ing the relevant rc file) to confirm it loads without errors.

## Architecture

### Shell config loading order (zsh and bash)

Both shells use a numbered drop-in directory sourced from the main rc file, so load order is controlled by filename prefix:

- Environment/PATH is set outside the drop-ins: `zsh/.zshenv` (deduped PATH, sourced by *every* zsh incl. scripts) and `zsh/.zprofile` (Nix + `XDG_DATA_DIRS`, login shells only). Keep `.zshenv` minimal and side-effect-free.
- `zsh/.zshrc` sources every `~/.zshrc.d/*.zsh` in order: `0020-bindkeys` → `0030-aliases` → `0040-colors` → `0045-zinit` (plugin manager) → `0050-completions` → `0060-history` → `0070-shell` → `0080-terminal` → `0110-zstyle` → `0120-starship` (prompt) → `0130-fzf`.
- `bash/.bashrc` sources every `~/.bashrc.d/*.bashrc` similarly.

When adding new shell config, drop a new numbered file into the appropriate `.zshrc.d`/`.bashrc.d` rather than editing the monolithic rc file — the prefix number determines when it runs relative to plugin manager init and prompt init. (`0045-zinit` deliberately precedes `0050-completions` so completion-providing plugins are on `fpath` before `compinit` runs.)

zsh uses `zinit` as its plugin manager (`0045-zinit.zsh`) and `starship` as the prompt (`0120-starship.zsh`). Both self-bootstrap (zinit clones itself on first run if missing).

### Multi-identity git and SSH

This setup juggles multiple git/GitHub identities for different work contexts:

- `git/.gitconfig` sets the default identity (JaiPi / personal GitHub) and uses `includeIf "gitdir:..."` to swap in a different identity file when working inside specific path prefixes (`.../repos/zap/*`, `.../repos/nos/*`).
- `git/repos/celfocus/.gitconfig` is one such override — it's *not* stowed as a top-level file, it exists purely for another `.gitconfig` (outside this repo, on the machine) to `path`-include.
- `ssh/.ssh/config` defines two SSH hosts against the same `github.com` hostname (`github.com` and `github.celfocus`) with different `IdentityFile`/`User`, so repos pick an identity via their remote URL host alias, not global SSH config.

Commit signing is enabled by default (`commit.gpgsign = true`, `gpg.format = ssh`, signing key at `~/.ssh/JaiPi.pub`).

### AWS credential/MFA scripts

`aws/aws-credentials/*.sh` and `aws/awslogin/*.sh` are STS helper scripts that exchange an MFA token code for temporary credentials (`aws sts get-session-token`, optionally followed by `aws sts assume-role`) and write them into named AWS CLI profiles via `aws configure set`. `aws/awslogin/login-aws` and `aws/aws-credentials/aws-mfa-arns` are lookup tables mapping profile/account names to their MFA device ARNs — scripts `awk`/`grep` these files by profile name rather than hardcoding ARNs inline. These print credentials to stdout (by design, for the interactive workflow); treat any output from running them as sensitive.

### `claude/.claude/agents`

Custom Claude Code subagent definitions, stowed to `~/.claude/agents/` so they're available globally across projects.

## Working in this repo — gotchas

- **`zsh/.config/` is a live, stowed directory, not a clean package.** Because it's symlinked to the real `~/.config`, application runtime data (gcloud tokens/logs, browser crash reports, tool caches, CLI configs written by `gh`, `varlock`, etc.) accumulates there constantly. The root-level `.gitignore` (`/.gitignore`, *not* inside `zsh/.config/`) allowlists only `zsh/.config/starship.toml` and ignores everything else under `zsh/.config/*` — this is deliberate so that `~/.config` cruft never needs individual gitignore entries. If a new file genuinely needs to be tracked from `zsh/.config/`, add an explicit `!zsh/.config/<path>` negation to the root `.gitignore` rather than removing the blanket ignore. Don't put a `.gitignore` back inside `zsh/.config/` itself — that would get stowed into `~/.config/.gitignore`, polluting the live directory.
- The `aws/aws-credentials/aws-mfa-arns` and `aws/awslogin/login-aws` files contain real AWS account IDs and IAM usernames. They're existing tracked content, but don't casually add more personally-identifying or credential-adjacent data to this repo.
- `.gitattributes` forces LF line endings for `*.sh` and normalizes text generally, with CRLF only for `*.cmd`/`*.bat` — keep new shell scripts LF.
