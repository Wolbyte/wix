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
    programs.rofi = {
      enable = true;

      package = rofiPackage;

      plugins = with pkgs; [
        rofi-calc
        rofi-emoji
        rofi-rbw
      ];
    };
  };
}
