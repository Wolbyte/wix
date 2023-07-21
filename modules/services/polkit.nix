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

    agent = rec {
      package =
        mkPackageOpt "polkit agent"
        (
          if cfg.flavor == "kde"
          then pkgs.libsForQt5.polkit-kde-agent
          else pkgs.polkit_gnome
        );

      executableName = defaultOpts.mkStr "polkit-${cfg.flavor}-authentication-agent-1" "Polkit agent's executable name.";

      executablePath = defaultOpts.mkStr "${package.default}/libexec/${executableName.default}" "Path to the agent's executable.";

      systemdIntegration = defaultOpts.mkBool false "Whether to create a systemd service to start the agent";
    };
  };

  config = mkIf cfg.enable {
    user.packages = [cfg.agent.package];

    security.polkit.enable = true;

    systemd.user.services."polkit-${cfg.flavor}-agent" = mkIf cfg.agent.systemdIntegration {
      description = "polkit-${cfg.flavor}";
      documentation = ["man:polkit(8)"];
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = cfg.agent.executablePath;
        RestartSec = 3;
        Restart = "always";
        TimeoutStopSec = 10;
      };
    };
  };
}
