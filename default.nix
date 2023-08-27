{
  pkgs,
  config,
  inputs,
  lib,
  nix-colors,
  ...
}:
with lib;
with lib.wb; {
  imports =
    [
      inputs.grub2-themes.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      inputs.nix-colors.homeManagerModules.default
    ]
    ++ (mapFilesRecursive' (toString ./modules) import);

  colorScheme = nix-colors.colorSchemes.rose-pine;

  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
  };

  system.stateVersion = "23.05";

  boot = {
    kernelPackages = mkDefault (pkgs.linuxPackagesFor (pkgs.linux_6_4.override {
      argsOverride = rec {
        src = pkgs.fetchurl {
          url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
          sha256 = "sha256-xZ804Z6E2zAga5NzBBq/iT+digh2XRY1hlcKUjjEWLY=";
        };
        version = "6.4.8";
        modDirVersion = "6.4.8";
      };
    }));

    loader = {
      efi = {
        canTouchEfiVariables = mkDefault true;
      };
      grub = {
        device = mkDefault "nodev";
        enable = mkDefault true;
        efiSupport = mkDefault true;
        useOSProber = mkDefault false;
      };
      grub2-theme = {
        enable = true;
        theme = "stylish";
        icon = "color";
      };
    };
  };

  networking.networkmanager.enable = true;

  user.initialPassword = "nixos";
  users.users.root.initialPassword = "nixos";

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    unzip
  ];
}
