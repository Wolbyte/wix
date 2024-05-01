{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  sessions = config.services.displayManager.sessionData.desktops;
  sessionsPath = concatStringsSep ":" [
    "${sessions}/share/xsessions"
    "${sessions}/share/wayland-sessions"
  ];
in {
  config = {
    # unlock GPG keyring on login
    security.pam.services = {
      login = {
        enableGnomeKeyring = true;
        gnupg = {
          enable = true;
          noAutostart = true;
          storeOnly = true;
        };
      };

      greetd = {
        gnupg.enable = true;
        enableGnomeKeyring = true;
      };
    };

    services = {
      xserver.displayManager.session = [
        {
          manage = "desktop";
          name = "Hyprland";
          start = "Hyprland";
        }
      ];

      greetd = {
        enable = true;
        vt = 2;
        settings = {
          default_session = {
            user = "greeter";
            command = concatStringsSep " " [
              (getExe pkgs.greetd.tuigreet)
              "--time"
              "--remember"
              "--remember-user-session"
              "--asterisks"
              "--sessions '${sessionsPath}'"
            ];
          };
        };
      };
    };
  };
}
