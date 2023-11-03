{
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib; let
  inherit (osConfig.wb) device programs;

  acceptedTypes = ["desktop" "hybrid"];

  isAccepted = builtins.elem device.profile acceptedTypes;
in {
  config = mkIf (isAccepted && programs.cli.enable) {
    home.packages = with pkgs; [
      cmake
      gcc
      imagemagick
      libnotify
    ];
  };
}
