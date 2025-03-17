{ config, pkgs, ... }: {
  # Enable nix
  nix.enable = true;
  nix.package = pkgs.nix;

  # Set nix build user group ID to avoid UID mismatch errors
  ids.gids.nixbld = 350;

  # Set macOS system preferences
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true; # Show file extensions
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false; # Disable press-and-hold for key repeats
  system.defaults.NSGlobalDomain.KeyRepeat = 2; # Set key repeat speed
  system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark"; # Enable dark mode by default
  system.defaults.NSGlobalDomain.NSWindowResizeTime = 0.001; # Faster window resizing

  # Disable guest account
  system.defaults.loginwindow.GuestEnabled = false;

  # Set Finder preferences
  system.defaults.finder.FXPreferredViewStyle = "clmv"; # Use column view in Finder
  system.defaults.finder.ShowPathbar = true; # Show path bar in Finder
  system.defaults.finder.AppleShowAllFiles = true; # Show hidden files in Finder

  # Set screenshot location
  system.defaults.screencapture.location = "$HOME/grimorium/Screenshots";

  # Disable "Are You Sure You Want to Open This App?" warning
  system.defaults.LaunchServices.LSQuarantine = false;

  # Add grimorium folder to Finder favorites
  system.activationScripts.addFinderFavorite.text = ''
    osascript -e "tell application \"Finder\" to make new alias at POSIX file \"$HOME\" to POSIX file \"$HOME/grimorium\" with properties {name:\"grimorium\"}"
  '';

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
      '{tile-data={file-data={_CFURLString="/Applications/Postman.app"; _CFURLStringType=15;};};}' \
      '{tile-data={file-data={_CFURLString="/Applications/Zen Browser.app"; _CFURLStringType=15;};};}' \
      '{tile-data={file-data={_CFURLString="/Applications/Obsidian.app"; _CFURLStringType=15;};};}' \
      '{tile-data={file-data={_CFURLString="/Applications/Slack.app"; _CFURLStringType=15;};};}' \
      '{tile-data={file-data={_CFURLString="/System/Applications/Calendar.app"; _CFURLStringType=15;};};}'
    killall Dock
  '';

  # Use Zsh as the default shell
  programs.zsh.enable = true;

  # State version
  system.stateVersion = 4;
}