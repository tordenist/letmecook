{
  description = "Nix-based macOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = { self, nixpkgs, nix-darwin, nix-homebrew}: 
    let
      system = "aarch64-darwin";  # Change to "x86_64-darwin" for Intel Macs
      pkgs = import nixpkgs { inherit system; };
    in {
      darwinConfigurations.obsidian-flake = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          nix-homebrew.darwinModules.nix-homebrew  # Correct nix-homebrew reference
          ./darwin.nix
          ./homebrew.nix
          ./packages.nix
          {
            nix-homebrew = {
              enable = true;  # Enable nix-homebrew management
              enableRosetta = true;  # Ensure Rosetta 2 support for x86_64 packages
              user = "calliop3";  # Set correct user for managing Homebrew
              # Optional: Enable fully-declarative tap management
              mutableTaps = false;
            };
          }
        ];
      };
    };
}

