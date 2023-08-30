{
  description = "Wolbyte's NixOS configuration";

  inputs = {
    # Core dependencies
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    base16-schemes = {
      url = "github:tinted-theming/base16-schemes";
      flake = false;
    };

    nix-colors = {
      url = "github:misterio77/nix-colors";
      inputs.base16-schemes.follows = "base16-schemes";
    };

    # Extra dependencies
    grub2-themes.url = "github:vinceliuice/grub2-themes";
    grub2-themes.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

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
      overlays = [self.overlay] ++ (lib.attrValues self.overlays);
    };
  in
    with lib;
    with lib.wb; {
      lib = lib.wb;

      overlay = final: prev: {
        wb = self.packages."${system}";
      };

      overlays = import ./overlays;

      packages."${system}" = mapFiles ./packages (p: pkgs.callPackage p {});

      nixosModules = mapFilesRecursive ./modules import;

      nixosConfigurations = mapHosts ./hosts {};
    };
}
