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
    programs.mpv = {
      enable = true;

      scripts = with pkgs.mpvScripts; [
        modernz # osc
        mpris # control mpv with media keys
        thumbfast # thumbnailer
      ];

      scriptOpts = {
        modernz = {
          hide_empty_playlist_button = "no";
          jump_amount = 5;
          ontop_button = "no";

          # OSC colors
          hover_effect_color = "#c4a7e7";
          held_element_color = "#6e6a86";

          seekbarfg_color = "#c4a7e7"; # color of the seekbar progress and handle
          seekbarbg_color = "#6e6a86"; # color of the remaining seekbar progress
        };
      };
    };
  };
}
