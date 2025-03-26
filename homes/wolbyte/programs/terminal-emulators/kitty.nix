{ lib, osConfig, ... }:
with lib;
let
  inherit (osConfig.wix) host;
in
{
  config = mkIf host.enableDesktopFeatures {
    programs.kitty = {
      enable = true;

      settings = {
        background_opacity = 0.8;

        confirm_os_window_close = 0;

        font_family = "monospace";

        font_size = 11;
      };
    };
  };
}
