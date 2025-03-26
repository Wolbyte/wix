{
  lib,
  config,
  ...
}:
let
  host = config.wix.host;
in
with lib;
{
  config = mkIf (host.displayServer == "wayland") {
    environment.variables = {
      NIXOS_OZONE_WL = mkDefault "1";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland,X11,*";
      QT_QPA_PLATFORM = "wayland;xcb";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };

    programs.hyprland.enable = host.desktopEnvironment == "Hyprland";
  };
}
