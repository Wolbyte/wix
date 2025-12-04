{
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib;
let
  inherit (osConfig.wix) host;
in
{
  config = mkIf host.enableDesktopFeatures {
    programs.obs-studio = {
      enable = true;

      package = pkgs.obs-studio.override {
        ffmpeg = pkgs.ffmpeg_6-full; # includes NVENC
        cudaSupport = true;
      };

      plugins =
        with pkgs.obs-studio-plugins;
        [
          obs-gstreamer
          obs-pipewire-audio-capture
          obs-vkcapture
        ]
        ++ (optionals (host.displayServer == "wayland") [
          pkgs.obs-studio-plugins.wlrobs
        ]);
    };
  };
}
