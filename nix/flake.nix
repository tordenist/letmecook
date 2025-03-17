{
  description = "Nix-based macOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = { self, nixpkgs, nix-darwin, nix-homebrew }: 
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
    in {
      darwinConfigurations.obsidian-flake = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          nix-homebrew.darwinModules.default  # Enable nix-homebrew
          ./darwin.nix
          ./homebrew.nix
          ./packages.nix
        ];

        specialArgs = {
          homebrew = {
            enable = true;
            onActivation.autoUpdate = false;
            brewPrefix = "/opt/homebrew";
            user = "calliop3";
            global = {
              autoUpdate = false;
            };
            rosetta = true;
          };
        };
      };
    };
}
