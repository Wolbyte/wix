{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  inherit (config.wb) env;
  sys = config.wb.system;
in {
  config = mkIf sys.video.enable {
    xdg.portal = {
      enable = true;

      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];

      wlr = {
        enable = mkForce (env.isWayland && env.desktopEnv != "Hyprland");
        settings = {
          screencast = {
            max_fps = 60;
            chooser_type = "simple";
            chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
          };
        };
      };
    };
  };
}
