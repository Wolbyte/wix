{
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib; let
  inherit (osConfig.wb) device env programs;

  acceptedTypes = ["desktop" "hybrid"];

  isAccepted = builtins.elem device.profile acceptedTypes;
in {
  config = mkIf (isAccepted && programs.cli.enable && env.isWayland) {
    home.packages = with pkgs; [
      grim
      slurp
      wl-clipboard
      wtype
    ];
  };
}
