# Stow Configuration Repository

This repository is designed to manage and deploy configuration files using **GNU Stow**, a symlink manager. It allows for easy, modular organization of dotfiles and configurations across multiple systems.

---

## Directory Structure

Each directory in this repository represents a "package" for a specific set of configuration files. The general structure is:

```plaintext
stow/
├── bin/    # Custom scripts or binaries
├── vim/    # Vim configurations
├── git/    # Git configurations (e.g., .gitconfig)
├── zsh/    # Zsh shell configurations
└── ...     # Add other packages as needed
```
## Requirements
GNU Stow: Ensure GNU Stow is installed on your system. On most Linux systems, you can install it via your package manager:

```bash
sudo dnf install stow   # For Fedora/AlmaLinux/RHEL
sudo apt install stow   # For Debian/Ubuntu
brew install stow       # For macOS
```
## Usage
### Stowing a Package
To apply a package (e.g., vim) to your home directory:

```bash
stow vim
```
This command creates symlinks from the vim/ package in the repository to the appropriate locations in your home directory.

### Unstowing a Package
To remove the symlinks created by a package:

```bash
stow -D vim
```
### Stowing Multiple Packages
You can stow multiple packages at once:

```bash
stow vim git zsh
```
### Simulate Changes
To preview the changes without applying them:

```bash
stow --simulate vim
```

## Best Practices
- Keep it Modular: Organize configurations into separate directories (packages) for easy management and portability.
- Use Relative Paths: Ensure that files within your packages are placed in a structure that mimics their target location (e.g., vim/.vimrc).
- Avoid Conflicts: Check for existing files or symlinks in the target directory to prevent conflicts.

## Example: Adding a New Package
1. Create a directory for the package:

```bash
mkdir bash
```
2. Place your configuration files inside this directory, mimicking their target structure:

```plaintext
bash/
└── .bashrc
```
3. Stow the package:

```bash
stow bash
```
## Troubleshooting
### Conflict Warnings
If Stow encounters a conflict (e.g., existing files or absolute symlinks), you can:
- Resolve the conflict manually.
- Use the --override flag to force the operation.

### Permission Issues
Ensure you have the necessary permissions to create symlinks in the target directory.

