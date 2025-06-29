{
  description = "";

  inputs = {
    # Core
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hypr
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { withSystem, ... }:
      {
        flake =
          let
            lib = import ./lib { pkgs = nixpkgs; };
          in
          {
            nixosConfigurations = import ./hosts {
              inherit
                self
                inputs
                lib
                withSystem
                ;
            };
          };

        perSystem =
          { pkgs, lib, ... }:
          {
            packages = lib.packagesFromDirectoryRecursive {
              inherit (pkgs) callPackage;
              directory = ./packages;
            };

            formatter = pkgs.nixfmt-rfc-style;
          };

        systems = [ "x86_64-linux" ];
      }
    );
}
