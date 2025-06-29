{
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib;
let
  inherit (osConfig.wix) host;

  rofiPackage = if host.displayServer == "wayland" then pkgs.rofi-wayland else pkgs.rofi;
in
{
  config = mkIf host.enableDesktopFeatures {
    home.packages = with pkgs; [
      (rofiPackage.override {
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
