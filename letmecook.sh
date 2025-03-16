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

# Ensure Xcode Command Line Tools are installed
echo_status "Checking for Xcode Command Line Tools..."
xcode-select --install 2>/dev/null || echo_status "Xcode Command Line Tools already installed."

# Install Nix & Enable Flakes
echo_status "Installing Nix and enabling Flakes..."
if ! command -v nix &> /dev/null; then
    bash -c "$(curl -L https://nixos.org/nix/install) --daemon"
fi
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

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

# Install nix-darwin configuration
echo_status "Applying Nix-Darwin configuration..."
nix run nix-darwin -- switch --flake "$DOTFILES_DIR/nix#obsidian-flake"

# Apply dotfiles with Stow
echo_status "Applying dotfiles with Stow..."
cd "$DOTFILES_DIR/stow"
stow zsh
stow .config

# Final message
echo_status "Installation complete! Restart your terminal to apply all changes."