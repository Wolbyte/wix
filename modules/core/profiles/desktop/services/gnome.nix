{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  inherit (config.wb) device;
  accpetedTypes = ["desktop" "hybrid"];
in {
  config = mkIf (builtins.elem device.profile accpetedTypes) {
    services = {
      udev.packages = with pkgs; [
        gnome.gnome-settings-daemon
      ];

      gnome = {
        gnome-online-accounts.enable = true;

        gnome-keyring.enable = true;
      };
    };
  };
}
