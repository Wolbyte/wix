{
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}:
with lib;
with lib.wb; let
  inherit (osConfig.wb) env system;
in {
  config = mkIf (env.isWayland && system.video.enable) {
    systemd.user.services = {
      swaybg = mkGraphicalService {
        Unit.Description = "Wallpaper Service";
        Service = let
          wallnix = inputs.wallnix.packages.${pkgs.system};
        in {
          ExecStart = "${getExe pkgs.swaybg} -i ${wallnix.alena-aenami}/share/wallpapers/alena-aenami/1.jpg";
          Restart = "always";
        };
      };
    };
  };
}
