{ config, pkgs, ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; # Fully remove unused packages
    brews = [
      "act" "amass" "antidote" "bat" "btop" "dnstwist" "eza" "feroxbuster" "fzf"
      "gh" "git" "glow" "grype" "hey" "httpie" "john-jumbo" "jq" "lazygit"
      "lefthook" "libpcap" "masscan" "mise" "mtr" "neofetch" "neovim"
      "nmap" "pre-commit" "procs" "ripgrep" "ruff" "scorecard" "shellcheck"
      "sops" "starship" "stow" "syft" "thefuck" "theharvester" "tldr" "tmux" "tree" "yq"
      "zoxide"
    ];
    casks = [
      "amethyst" "docker" "font-hack-nerd-font" "font-mononoki-nerd-font" "ghostty"
      "google-chrome" "google-cloud-sdk" "kitty" "obsidian" "podman-desktop" "postman"
      "slack" "spotify" "stats" "zen-browser" "1password" "1password-cli"
    ];
    taps = [ "caffix/amass" "fluxcd/tap" "homebrew/bundle" "jesseduffield/lazygit" ];
  };
}
