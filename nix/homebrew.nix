{ config, pkgs, ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; # Fully remove unused packages
    brews = [
      "act" "amass" "bat" "btop" "dnstwist" "eza" "feroxbuster" "fzf" 
      "gh" "git" "glow" "hey" "httpie" "john-jumbo" "jq" "lazygit" 
      "lefthook" "libpcap" "masscan" "mise" "mtr" "neofetch" "neovim" 
      "nmap" "pre-commit" "procs" "ripgrep" "ruff" "scorecard" "shellcheck" 
      "sops" "starship" "stow" "theharvester" "tldr" "tmux" "tree" "yq" 
      "zoxide"
    ];
    casks = [
      "amethyst" "font-hack-nerd-font" "font-mononoki-nerd-font" "ghostty" 
      "google-chrome" "google-cloud-sdk" "kitty" "postman" "spotify" "stats" "zen-browser"
    ];
    taps = [ "caffix/amass" "fluxcd/tap" "homebrew/bundle" "jesseduffield/lazygit" ];
  };
}