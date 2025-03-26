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

      wireplumber.enable = true;

      pulse.enable = true;

      jack.enable = true;

      alsa.enable = true;
    };

    systemd.user.services = {
      pipewire.wantedBy = [ "default.target" ];

      pipewire-pulse.wantedBy = [ "default.target" ];
    };

    # Required for 'pactl'
    environment.systemPackages = with pkgs; [ pulseaudio ];
  };
}
