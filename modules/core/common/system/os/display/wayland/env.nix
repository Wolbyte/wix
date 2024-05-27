{
  config,
  lib,
  ...
}:
with lib; let
  inherit (config.wb) env;
  sys = config.wb.system;
in {
  config = mkIf (env.isWayland && sys.video.enable) {
    environment = {
      variables = {
        _JAVA_AWT_WM_NONEREPARENTING = "1";
        # NIXOS_OZONE_WL = "1";

        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        SDL_VIDEODRIVER = "wayland";
        XDG_SESSION_TYPE = "wayland";
      };
    };
  };
}
