{
  pkgs,
  inputs,
  lib,
  self,
  ...
}:
with lib; {
  system = {
    stateVersion = mkDefault "23.05";
  };

  environment = {
    etc."nixos/flake".source = self;

    systemPackages = [pkgs.git];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
    };
  };

  documentation = {
    doc.enable = false;
    nixos.enable = true;
    info.enable = false;
    man = {
      enable = true;
      generateCaches = true;
    };
  };

  nix = {
    registry = let
      reg = mapAttrs (_: v: {flake = v;}) inputs;
    in
      reg // {default = reg.nixpkgs;};

    settings = {
      auto-optimise-store = true;

      allowed-users = ["@wheel"];
      trusted-users = ["@wheel"];

      log-lines = 30;

      extra-experimental-features = [
        "flakes"
        "nix-command"
      ];

      warn-dirty = false;

      http-connections = 50;

      builders-use-substitutes = true;

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://nixpkgs-unfree.cachix.org"
        "https://numtide.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
    };
  };
}
