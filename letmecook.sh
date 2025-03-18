#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -o pipefail  # Catch errors in piped commands

# Define paths
DOTFILES_DIR="$HOME/grimorium/letmecook"
REPO_URL="https://github.com/tordenist/letmecook.git"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No color

# Function to print status messages
echo_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

# Ensure grimorium directory exists
if [ ! -d "$HOME/grimorium" ]; then
    echo_status "Creating grimorium directory..."
    mkdir -p "$HOME/grimorium"
fi

# Ensure Xcode Command Line Tools are installed
if ! xcode-select -p &>/dev/null; then
    echo_status "Installing Xcode Command Line Tools..."
    xcode-select --install
else
    echo_status "Xcode Command Line Tools already installed."
fi

# Install Nix & Enable Flakes
echo_status "Installing Nix and enabling Flakes..."
if ! command -v nix &> /dev/null; then
    bash -c "$(curl -fsSL https://nixos.org/nix/install)" --daemon
    echo_status "Nix installation complete! Reloading shell..."
    exec $SHELL -l  # Reload the shell to apply Nix changes
fi
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Ensure correct nixbld UID migration (for macOS Sequoia 15+)
echo_status "Migrating nixbld users to new UID range..."
curl --proto '=https' --tlsv1.2 -sSf -L https://github.com/NixOS/nix/raw/master/scripts/sequoia-nixbld-user-migration.sh | bash -

# Clone the dotfiles repository
echo_status "Cloning dotfiles repository..."
if [ ! -d "$DOTFILES_DIR" ]; then
    git clone "$REPO_URL" "$DOTFILES_DIR"
else
    echo_status "Repository already exists. Skipping clone."
fi

# Ensure we are in the correct directory for Nix-Darwin
cd "$DOTFILES_DIR/nix"
if [ ! -f "flake.nix" ]; then
    echo -e "${YELLOW}[WARNING]${NC} flake.nix not found in $DOTFILES_DIR/nix. Aborting Nix-Darwin setup."
    exit 1
fi

# Ensure Nix does not fail due to existing configuration
if [ -f /etc/nix/nix.conf ]; then
    echo "[INFO] Backing up existing /etc/nix/nix.conf to /etc/nix/nix.conf.before-nix-darwin"
    sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin
fi

# Install nix-darwin configuration
echo_status "Applying Nix-Darwin configuration..."
nix run nix-darwin -- switch --flake "$DOTFILES_DIR/nix#obsidian-flake"

# Reload shell to apply Nix-Darwin changes
echo_status "Reloading shell after Nix-Darwin installation..."
exec $SHELL -l  # Reload the shell

# Apply dotfiles with Stow
echo_status "Applying dotfiles with Stow..."
cd "$DOTFILES_DIR/stow"
stow -v -t ~ zsh
stow -v -t ~/.config .config  # Keeping your `.config` naming

# Reload shell to apply new dotfiles
echo_status "Reloading shell to apply new dotfiles..."
exec $SHELL -l  # Reload the shell again

# Final message
echo_status "Installation complete! Your terminal is now using the updated configuration."