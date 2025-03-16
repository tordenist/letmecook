{ config, pkgs, ... }: {
  # Enable nix-darwin system services
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Set system hostname
  networking.hostName = "obsidian-flake";

  # Set macOS system preferences
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true; # Show file extensions
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false; # Disable press-and-hold for key repeats
  system.defaults.NSGlobalDomain.KeyRepeat = 2; # Set key repeat speed
  system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark"; # Enable dark mode by default

  # Set a specific wallpaper
  system.activationScripts.setWallpaper.text = ''
    osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$HOME/grimorium/letmecook/wallpaper/muses.jpeg\""
  '';

  # Configure Dock preferences
  system.defaults.dock.autohide = true; # Automatically hide the dock
  system.defaults.dock.static-only = true; # Only show pinned apps
  system.activationScripts.setDockApps.text = ''
    defaults write com.apple.dock persistent-apps -array \
      '{tile-data={file-data={_CFURLString="/Applications/Ghostty.app"; _CFURLStringType=15;};};}' \
      '{tile-data={file-data={_CFURLString="/Applications/Spotify.app"; _CFURLStringType=15;};};}' \
      '{tile-data={file-data={_CFURLString="/Applications/Postman.app"; _CFURLStringType=15;};};}'
    killall Dock
  '';

  # Suggested additional macOS settings (Can be removed if not needed)
  # system.defaults.NSGlobalDomain.InitialKeyRepeat = 15; # Delay before key repeat
  # system.defaults.finder.ShowPathbar = true; # Show path bar in Finder
  # system.defaults.finder.FXEnableExtensionChangeWarning = false; # Disable extension change warning
  # system.defaults.dock.mru-spaces = false; # Disable recent spaces in Mission Control
  # system.defaults.trackpad.Clicking = true; # Enable tap to click

  # Use Zsh as the default shell
  programs.zsh.enable = true;

  # State version
  system.stateVersion = 4;
}
