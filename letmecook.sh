#!/bin/bash

set -e          # Exit immediately if a command exits with a non-zero status
set -o pipefail # Catch errors in piped commands

# Define paths
DOTFILES_DIR="$HOME/grimorium/letmecook"
REPO_URL="https://github.com/tordenist/letmecook.git"
WALLPAPER="$DOTFILES_DIR/wallpaper/muses.jpeg"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No color

# Function to print status messages
echo_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

install_base() {
    echo_status "Installing base system dependencies..."

    # Ensure grimorium directory exists
    if [ ! -d "$HOME/grimorium" ]; then
        echo_status "Creating grimorium directory..."
        mkdir -p "$HOME/grimorium"
    fi

    # Clone repository if not present
    if [ ! -d "$DOTFILES_DIR" ]; then
        echo_status "Cloning dotfiles repository..."
        git clone "$REPO_URL" "$DOTFILES_DIR"
    else
        echo_status "Repository already exists. Skipping clone."
    fi

    # Ensure Xcode Command Line Tools are installed
    if ! xcode-select -p &>/dev/null; then
        echo_status "Installing Xcode Command Line Tools..."
        xcode-select --install
    else
        echo_status "Xcode Command Line Tools already installed."
    fi

    # Install Nix
    if ! command -v nix &>/dev/null; then
        echo_status "Installing Nix..."
        bash -c "$(curl -fsSL https://nixos.org/nix/install)" --daemon
    fi

    mkdir -p ~/.config/nix
    echo "experimental-features = nix-command flakes" >>~/.config/nix/nix.conf

    # Ensure correct nixbld UID migration (for macOS Sequoia 15+)
    echo_status "Migrating nixbld users to new UID range..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://github.com/NixOS/nix/raw/master/scripts/sequoia-nixbld-user-migration.sh | bash -

    exec $SHELL -l # Reload shell after installing Nix

    echo_status "Base system setup complete!"
}

install_dotfiles() {
    echo_status "Installing dotfiles with Stow..."

    cd "$DOTFILES_DIR/stow"
    stow -v -t ~ zsh
    stow -v -t ~/.config .config

    echo_status "Dotfiles installation complete!"

    echo_status "Installing Mise packages..."

    mise trust
    mise install

    echo_status "Mise packages were installed successfully!"

    echo_status "Creating TMUX conf symlink"

    # Remove existing file or symlink if it exists
    if [ -e ~/.tmux.conf ] || [ -L ~/.tmux.conf ]; then
        rm ~/.tmux.conf
    fi

    # Create the symlink
    ln -s "$DOTFILES_DIR/stow/.config/tmux/tmux.conf" ~/.tmux.conf

    echo_status "TMUX conf was successfully linked!"

    cd "$DOTFILES_DIR"

    exec $SHELL -l # Reload shell to apply changes
}

reload_nix() {
    echo_status "Reloading Nix environment..."

    cd "$DOTFILES_DIR/nix"
    if [ ! -f "flake.nix" ]; then
        echo -e "${YELLOW}[WARNING]${NC} flake.nix not found. Aborting Nix-Darwin setup."
        exit 1
    fi

    if [ -f /etc/nix/nix.conf ]; then
        echo_status "Backing up existing /etc/nix/nix.conf..."
        sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin
    fi

    nix run nix-darwin -- switch --flake "$DOTFILES_DIR/nix#obsidian-flake"

    cd "$DOTFILES_DIR"

    exec $SHELL -l # Reload shell after applying Nix changes

    echo_status "Nix environment reloaded!"
}

set_wallpaper() {
    echo_status "Setting wallpaper..."
    if [ -f "$WALLPAPER" ]; then
        osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$WALLPAPER\""
        echo_status "Wallpaper applied!"
    else
        echo -e "${YELLOW}[WARNING]${NC} Wallpaper file not found at $WALLPAPER. Skipping."
    fi
}

# Parse command-line arguments
for arg in "$@"; do
    case $arg in
    --install-base)
        install_base
        ;;
    --install-dotfiles)
        install_dotfiles
        ;;
    --reload-nix)
        reload_nix
        ;;
    --set-wallpaper)
        set_wallpaper
        ;;
    *)
        echo -e "${YELLOW}[WARNING]${NC} Unknown option: $arg"
        ;;
    esac
done
