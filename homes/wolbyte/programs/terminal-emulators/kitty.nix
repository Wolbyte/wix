{ lib, osConfig, ... }:
with lib;
let
  inherit (osConfig.wix) host;
in
{
  config = mkIf host.enableDesktopFeatures {
    programs.kitty = {
      enable = true;

      themeFile = "rose-pine";

      settings = {
        background_opacity = 0.9;

        confirm_os_window_close = 0;

        font_family = "monospace";

        font_size = 11;

        window_padding_width = 5;
      };
    };
  };
}
