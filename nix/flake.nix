{
  description = "Nix-based macOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager }: 
    let
      system = "aarch64-darwin";  # Change to x86_64-darwin for Intel Macs
      pkgs = import nixpkgs { inherit system; };
    in {
      darwinConfigurations.my-mac = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./darwin.nix
          ./homebrew.nix
          ./packages.nix
        ];
      };
    };
}