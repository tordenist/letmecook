{ config, pkgs, ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; # Fully remove unused packages
    brews = [
      "stow" "fzf" "tmux" "mise" "jq" "yq" "bat" "fzf" "ripgrep"
      "shellcheck" "starship" "act" "procs" "btop" "eza" "tldr"
      "mtr" "httpie" "masscan" "libpcap" "scorecard" "neovim"
      "git" "gh" "pre-commit" "stow" "lazygit" "lefthook" "google-cloud-sdk"
      "amass" "dnstwist" "feroxbuster" "john-jumbo" "nmap" "sqlmap" "theharvester"
      "glow" "neofetch" "ruff" "sops" "tree" "zoxide" "hey" "stats"
    ];
    casks = [
      "kitty" "spotify" "google-chrome" "postman" "ghostty"
      "amethyst" "font-hack-nerd-font" "font-mononoki-nerd-font"
    ];
    taps = [ "homebrew/cask-fonts" "caffix/amass" "fluxcd/tap" "homebrew/bundle"
      "homebrew/cask-versions" "jesseduffield/lazygit"
    ];
  };
}