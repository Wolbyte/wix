{
  description = "Wolbyte's NixOS configuration";

  inputs = {
    # Core dependencies
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    lib = nixpkgs.lib.extend (self: super: {
      wb = import ./lib {
        inherit pkgs inputs;
        lib = self;
      };
    });

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = lib.attrValues self.overlays;
    };
  in
    with lib;
    with lib.wb; {
      lib = lib.wb;

      overlays = mapFiles ./overlays import;

      packages."${system}" = mapFiles ./packages (p: pkgs.callPackage p {});

      nixosModules = mapFilesRec ./modules/nixos import;

      nixosConfigurations = mapHosts ./hosts {};

      homeManagerModules = mapFilesRecursive ./modules/home-manager import;

      homeConfigurations = mapHomes ./home {};
    };
}
