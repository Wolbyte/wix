{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
with lib; let
  inherit (config.wb) device;
  inherit (pkgs.stdenv) hostPlatform;

  isX86Linux = hostPlatform.isLinux && hostPlatform.isx86;

  sys = config.wb.system;
in {
  imports = [inputs.nix-gaming.nixosModules.pipewireLowLatency];

  config = mkIf (sys.audio.enable && device.hasSound) {
    # This is required to install pactl
    environment.systemPackages = with pkgs; [pulseaudio];

    sound = {
      enable = true;
      mediaKeys.enable = true;
    };

    security.rtkit.enable = config.services.pipewire.enable;

    services.pipewire = {
      enable = mkDefault true;
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = isX86Linux;
      };

      lowLatency = {
        enable = true;

        quantum = 64;
        rate = 48000;
      };
    };

    systemd.user.services = {
      pipewire.wantedBy = ["default.target"];
      pipewire-pulse.wantedBy = ["default.target"];
    };
  };
}
