{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  config = mkIf (config.wix.host.enableDesktopFeatures) {
    programs.dconf.enable = true;

    services = {
      gnome.gnome-keyring.enable = true;

      gvfs.enable = true;

      udisks2.enable = true;

      timesyncd.enable = true;

      dbus.packages = with pkgs; [ gcr ];
    };
  };
}
