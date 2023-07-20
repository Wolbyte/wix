{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.services.polkit;
in {
  options.wb.services.polkit = {
    enable = mkEnableOption "polkit";

    flavor = defaultOpts.mkEnumFirstDefault ["gnome" "kde"] "Polkit flavor to install.";
  };

  config = mkIf cfg.enable (let
    agent = rec {
      package =
        if cfg.flavor == "kde"
        then pkgs.libsForQt5.polkit-kde-agent
        else pkgs.polkit_gnome;

      executableName = "polkit-${cfg.flavor}-authentication-agent-1";

      executablePath = "${package}/libexec/${executableName}";
    };
  in {
    user.packages = [agent.package];

    security.polkit.enable = true;

    systemd.user.services."polkit-${cfg.flavor}-agent" = {
      description = "polkit-${cfg.flavor}";
      documentation = ["man:polkit(8)"];
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = agent.executablePath;
        RestartSec = 1;
        Restart = "on-failure";
        TimeoutStopSec = 10;
      };
    };
  });
}
