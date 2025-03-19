# 🍳 letmecook - My Nix-Darwin & Dotfiles Setup

**letmecook** is my fully automated macOS configuration, leveraging **nix-darwin**, **Homebrew**, and **Stow** to ensure a reproducible, efficient, and well-structured development environment.

---

## 🚀 Features
- **Declarative System Management** with [`nix-darwin`](https://github.com/LnL7/nix-darwin)
- **Package Management via Homebrew** (managed in `nix/homebrew.nix`)
- **Dotfile Management** using [`stow`](https://www.gnu.org/software/stow/)
- **Automated Setup Script** with modular installation options
- **Customized macOS Settings**, including:
  - Dark mode enabled by default
  - Key repeat speed set to `2`
  - Auto-hiding Dock with predefined pinned apps (Ghostty, Obsidian, Postman, etc)
  - Custom wallpaper set from `wallpaper/muses.jpeg`
  - More stuff but I don't feel like listing them all, fight me

---

## 📂 Folder Structure
```
letmecook/
│── nix/             # Nix-Darwin configuration
│   ├── flake.nix
│   ├── darwin.nix
│   ├── homebrew.nix
│   ├── packages.nix
│
│── stow/            # Dotfiles managed by GNU Stow
│   ├── zsh/
│   ├── .config/
│   ├── .stowrc
│
│── wallpaper/       # Wallpapers for customization
│   ├── muses.jpeg
│
│── brew-packages/   # Homebrew bundle management
│   ├── Brewfile
│
│── letmecook.sh     # Automated modular setup script
│
│── README.md        # Documentation
```

---

## 🔧 Installation

### **1️⃣ Run the Setup Script**
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/tordenist/letmecook/main/letmecook.sh)"
```

This script supports modular installation with the following options:

| Option               | Description                                        |
|----------------------|----------------------------------------------------|
| `--install-base`     | Installs Xcode Command Line Tools, Nix, and clones the repo |
| `--install-dotfiles` | Applies dotfiles using Stow                        |
| `--reload-nix`       | Reloads Nix and applies Nix-Darwin configuration  |
| `--set-wallpaper`    | Sets the wallpaper to `wallpaper/muses.jpeg`      |

For example, to only install dotfiles:
```sh
bash letmecook.sh --install-dotfiles
```

To apply everything in sequence:
```sh
bash letmecook.sh --install-base --install-dotfiles --reload-nix --set-wallpaper
```

---

## 📌 Updating

### **Update the Nix System Configuration**
```sh
nix flake update
nix run nix-darwin -- switch --flake .#my-mac
```

### **Resync Dotfiles with Stow**
```sh
stow --restow *
```

---

## 🔥 Credits & Inspirations
- [`nix-darwin`](https://github.com/LnL7/nix-darwin)
- [`dreamsofautonomy/nix-darwin`](https://github.com/dreamsofautonomy/nix-darwin)

---

## 🎯 Future Improvements
- Integrate additional macOS tweaks
- Improve Nix package management with overlays

---

## 💡 License
MIT License © tordenist 2025


