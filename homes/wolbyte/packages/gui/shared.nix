{
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib; let
  inherit (osConfig.wb) device programs system;

  acceptedTypes = ["desktop" "hybrid"];

  isAccepted = builtins.elem device.profile acceptedTypes;
in {
  config = mkIf (isAccepted && system.video.enable && programs.gui.enable) {
    home.packages = with pkgs; [
      telegram-desktop
    ];
  };
}
