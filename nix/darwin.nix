{ config, pkgs, ... }: {
  # Enable nix
  nix.enable = true;
  nix.package = pkgs.nix;

  # Set nix build user group ID to avoid UID mismatch errors
  ids.gids.nixbld = 350;

  # Set specific wallpaper
  #  system.activationScripts.setWallpaper.text = ''
  #osascript -e 'tell application "Finder" to set desktop picture to POSIX file "$HOME/grimorium/letmecook/wallpaper/muses.jpeg"'
  #'';

  # Set macOS system preferences
  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllExtensions = true;  # Show file extensions
      ApplePressAndHoldEnabled = false;  # Disable press-and-hold for key repeats
      KeyRepeat = 2;  # Set key repeat speed
      AppleInterfaceStyle = "Dark";  # Enable dark mode by default
      NSWindowResizeTime = 0.001;  # Faster window resizing
    };

    loginwindow = {
      GuestEnabled = false;  # Disable guest account
    };

    controlcenter = {
      BatteryShowPercentage = true;
      Sound = true;
    };

    finder = {
      FXPreferredViewStyle = "clmv";  # Use column view in Finder
      ShowPathbar = true;  # Show path bar in Finder
      AppleShowAllFiles = true;  # Show hidden files in Finder
    };

    screencapture = {
      location = "$HOME/grimorium/Screenshots";  # Set screenshot location
    };

    LaunchServices = {
      LSQuarantine = false;  # Disable "Are You Sure You Want to Open This App?" warning
    };

    dock = {
      autohide = true;  # Automatically hide the dock
      persistent-apps = [
        "/Applications/Ghostty.app"
        "/Applications/Spotify.app"
        "/Applications/Postman.app"
        "/Applications/Zen Browser.app"
        "/Applications/Obsidian.app"
        "/Applications/Slack.app"
        "/System/Applications/Calendar.app"
      ];
    };
  };

  # Use Zsh as the default shell
  programs.zsh.enable = true;

  # State version
  system.stateVersion = 4;
}

