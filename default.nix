{
  pkgs,
  inputs,
  lib,
  nix-colors,
  ...
}:
with lib;
with lib.wb; {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      inputs.nix-colors.homeManagerModules.default
    ]
    ++ (mapFilesRecursive' (toString ./modules) import);

  colorScheme = nix-colors.colorSchemes.rose-pine;

  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  system.stateVersion = "23.05";

  boot = {
    kernelPackages = mkDefault (pkgs.linuxPackagesFor (pkgs.linux_6_3.override {
      argsOverride = rec {
        src = pkgs.fetchurl {
          url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
          sha256 = "sha256-QezyE5mxerhRY3ULoiNH0JtU+gmbgLY9Di7wBmEpsT4=";
        };
        version = "6.3.9";
        modDirVersion = "6.3.9";
      };
    }));

    loader = {
      efi = {
        canTouchEfiVariables = mkDefault true;
      };
      grub = {
        enable = mkDefault true;
        efiSupport = mkDefault true;
        useOSProber = mkDefault false;
        device = mkDefault "nodev";
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
