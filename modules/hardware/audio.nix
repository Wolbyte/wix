{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.hardware.audio;
in {
  options.wb.hardware.audio = {
    enable = mkEnableOption "Audio support";
    pactl = defaultOpts.mkBool true "Whether to install pulseaudio for `pactl`";
  };

  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = false;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    security.rtkit.enable = true;

    environment.systemPackages =
      if cfg.pactl
      then [pkgs.pulseaudio]
      else [];
  };
}
