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
    home.packages = with pkgs; [
      (rofi.override {
        plugins = [
          rofi-calc
          rofi-emoji
          rofi-rbw
        ];
      })
    ];

    xdg.configFile = {
      "rofi/config.rasi".source = ./config.rasi;

      "rofi/rose-pine.rasi".source = ./rose-pine.rasi;
    };
  };
}
