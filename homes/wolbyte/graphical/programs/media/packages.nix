{
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib; let
  inherit (osConfig.wb) device;
  acceptedTypes = ["desktop" "hybrid"];
in {
  config = mkIf (builtins.elem device.profile acceptedTypes) {
    home.packages = with pkgs; [
      ffmpeg-full
      imv
      pavucontrol
      playerctl
    ];
  };
}
