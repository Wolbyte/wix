{
  pkgs,
  lib,
  inputs,
  self,
  ...
}:
with lib;
{
  system.stateVersion = mkDefault "24.11";

  # Keep a copy of the current build in the nixos dir
  environment.etc."nixos/flake".source = self;

  documentation = {
    doc.enable = false;

    nixos.enable = true;

    info.enable = false;

    man = {
      enable = true;

      generateCaches = true;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;

    allowBroken = false;
  };

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    settings = {
      auto-optimise-store = true;

      allowed-users = [ "@wheel" ];

      trusted-users = [ "@wheel" ];

      log-lines = 35;

      warn-dirty = false;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    nixd
    nixfmt-rfc-style
  ];
}
