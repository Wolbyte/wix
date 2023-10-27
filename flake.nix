{
  description = "Nix Flake";

  outputs = {
    self,
    nixpkgs,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} ({withSystem, ...}: {
      imports = [
        ./parts/settings.nix
      ];

      systems = ["x86_64-linux" "aarch64-linux"];

      perSystem = {
        inputs',
        config,
        pkgs,
        ...
      }: {
        imports = [{_module.args.pkgs = config.legacyPackages;}];
        formatter = pkgs.alejandra;
      };

      flake = let
        lib = import ./lib {inherit nixpkgs inputs;};
      in {
        nixosConfigurations = import ./hosts {inherit nixpkgs self lib withSystem;};
      };
    });

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";
  };
}
