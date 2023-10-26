{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  inherit (config.wb) env;
  sys = config.wb.system;
in {
  config = mkIf (env.isWayland && sys.video.enable) {
    systemd.services = {
      seatd = {
        enable = true;
        description = "Seat management daemon";
        script = "${getExe pkgs.seatd} -g wheel";
        serviceConfig = {
          Type = "simple";
          Restart = "always";
          RestartSec = "1";
        };
        wantedBy = ["multi-user.target"];
      };
    };
  };
}
