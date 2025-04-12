{
  pkgs,
  lib,
  config,
  ...
}:
let
  host = config.wix.host;
in
with lib;
{
  config = mkIf host.enableSound {
    security.rtkit.enable = config.services.pipewire.enable;

    services.pipewire = {
      enable = true;

      pulse.enable = true;

      jack.enable = true;

      alsa.enable = true;

      wireplumber = {
        enable = true;

        configPackages = [
          (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/99-disable-suspension.conf" ''
            monitor.alsa.rules = [
              {
                matches = [ { node.name = "~alsa_output.*" } ]
                actions = {
                  update-props = {
                    session.suspend-timeout-seconds = 0
                  }
                }
              }
            ]
          '')
        ];
      };
    };

    systemd.user.services = {
      pipewire.wantedBy = [ "default.target" ];

      pipewire-pulse.wantedBy = [ "default.target" ];
    };

    # Required for 'pactl'
    environment.systemPackages = with pkgs; [ pulseaudio ];
  };
}
