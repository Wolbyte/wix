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
    utils = defaultOpts.mkBool false "Whether to install useful utilities such as pavucontrol.";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      hardware.pulseaudio.enable = false;

      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };

      security.rtkit.enable = true;
    }

    (mkIf cfg.pactl {
      environment.systemPackages = [pkgs.pulseaudio];
    })

    (mkIf cfg.utils {
      environment.systemPackages = with pkgs; [
        pavucontrol
        playerctl
      ];
    })
  ]);
}
