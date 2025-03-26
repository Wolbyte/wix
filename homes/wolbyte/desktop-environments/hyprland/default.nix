{
  lib,
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

          settings = import ./config.nix { inherit config; };
        };
      };
}
