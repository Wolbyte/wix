{
  pkgs,
  lib,
  ...
}:
with lib; {
  imports = [./locale.nix];

  config = {
    environment = {
      defaultPackages = mkForce [];

      systemPackages = with pkgs; [
        git
        curl
        wget
        lshw
      ];
    };
  };
}
