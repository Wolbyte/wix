{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  config = mkIf (config.wix.host.enableDesktopFeatures) {
    services.dbus.packages = with pkgs; [
      dconf

      gcr
    ];
  };
}
