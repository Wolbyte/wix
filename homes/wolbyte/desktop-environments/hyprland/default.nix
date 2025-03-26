{
  lib,
  inputs',
  config,
  osConfig,
  ...
}:
with lib;
let
  inherit (osConfig.wix) host;
in
{
  config =
    mkIf
      (
        host.displayServer == "wayland"
        && host.desktopEnvironment == "Hyprland"
        && host.enableDesktopFeatures
      )
      {
        wayland.windowManager.hyprland = {
          enable = true;

          package = inputs'.hyprland.packages.hyprland;

          portalPackage = inputs'.hyprland.packages.xdg-desktop-portal-hyprland;

          systemd.variables = [ "--all" ];

          settings = import ./config.nix { inherit config; };
        };
      };
}
