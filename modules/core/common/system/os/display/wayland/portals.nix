{
  pkgs,
  inputs',
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

      extraPortals =
        [
          pkgs.xdg-desktop-portal-gtk
        ]
        ++ (optionals (env.desktopEnv == "Hyprland") [
          inputs'.xdg-portal-hyprland.packages.xdg-desktop-portal-hyprland
        ]);

      config = {
        common = let
          portal =
            if env.desktopEnv == "Hyprland"
            then "hyprland"
            else "wlr";
        in {
          default = "gtk";
          "org.freedesktop.impl.portal.Screencast" = "${portal}";
          "org.freedesktop.impl.portal.Screenshot" = "${portal}";
        };
      };

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
