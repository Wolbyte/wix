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
      # Userspace virtual file system.
      gvfs.enable = true;

      # Thumbnailer for thunar.
      tumbler.enable = true;

      # Used by udiskie
      udisks2.enable = true;

      dbus = {
        enable = true;
        packages = with pkgs; [dconf gcr udisks2];
      };

      timesyncd.enable = mkDefault true;
      chrony.enable = mkDefault false;
    };
  };
}
