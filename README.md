# 🍳 letmecook - My Nix-Darwin & Dotfiles Setup

**letmecook** is my fully automated macOS configuration, leveraging **nix-darwin**, **Homebrew**, and **Stow** to ensure a reproducible, efficient, and well-structured development environment.

---

## 🚀 Features
- **Declarative System Management** with [`nix-darwin`](https://github.com/LnL7/nix-darwin)
- **Package Management via Homebrew** (managed in `nix/homebrew.nix`)
- **Dotfile Management** using [`stow`](https://www.gnu.org/software/stow/)
- **Customized macOS Settings**, including:
  - Dark mode enabled by default
  - Key repeat speed set to `2`
  - Auto-hiding Dock with predefined pinned apps (Ghostty, Spotify, Postman)
  - Custom wallpaper set from `wallpaper/muses.jpeg`

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
│── letmecook.sh     # Automated setup script
│
│── README.md        # Documentation
```

---

## 🔧 Installation

### **1️⃣ Run the Setup Script**
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/tordenist/letmecook/main/letmecook.sh)"
```

This script will:
- Install **Xcode Command Line Tools** (if missing)
- Install **Nix** and enable **Flakes**
- Clone the **letmecook** repository (via SSH or HTTPS with GitHub Token)
- Apply **nix-darwin** system configuration
- Apply **dotfiles with Stow**

---

## 📌 Updating

To update the system, run:
```sh
nix flake update
nix run nix-darwin -- switch --flake .#my-mac
```

To sync dotfiles:
```sh
stow --restow *
```

---

## 🔥 Credits & Inspirations
- [`nix-darwin`](https://github.com/LnL7/nix-darwin)
- [`dreamsofautonomy/nix-darwin`](https://github.com/dreamsofautonomy/nix-darwin)
- [`yadm`](https://github.com/TheLocehiliosan/yadm) (for inspiration on dotfile management)

---

## 🎯 Future Improvements
- Integrate additional macOS tweaks
- Automate setup with a bootstrap script
- Improve Nix package management with overlays

---

## 💡 License
MIT License © tordenist 2025
