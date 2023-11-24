{
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib; let
  inherit (osConfig.wb) device env;

  allowedTypes = ["desktop" "hybrid"];
in {
  config = mkIf (builtins.elem device.profile allowedTypes) {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins;
        [
          obs-gstreamer
          obs-pipewire-audio-capture
          obs-vkcapture
        ]
        ++ optional env.isWayland wlrobs;
    };
  };
}
