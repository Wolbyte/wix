{
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib;
let
  inherit (osConfig.wix) host;
in
{
  config = mkIf (host.displayServer != null) {
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      Unit.description = "polkit-gnome-authentication-agent-1";

      Install = {
        WantedBy = [ "graphical-session.target" ];

        Wants = [ "graphical-session.target" ];

        After = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";

        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";

        Restart = "on-failure";

        RestartSec = 1;

        TimeoutStopSec = 5;
      };
    };
  };
}
