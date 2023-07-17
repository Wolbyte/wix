{
  description = "Wolbyte's NixOS configuration";

  inputs = {
    # Core dependencies
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:misterio77/nix-colors";

    # Extra dependencies
    hyprland.url = "github:hyprwm/Hyprland";

    nixvim.url = "github:nix-community/nixvim";

    spicetify-nix.url = "github:the-argus/spicetify-nix";
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

      overlays = import ./overlays;

      packages."${system}" = mapFiles ./packages (p: pkgs.callPackage p {});

      nixosModules = mapFilesRecursive ./modules import;

      nixosConfigurations = mapHosts ./hosts {};
    };
}
