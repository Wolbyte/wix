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
    services.dunst = {
      enable = true;

      settings.global = {
        font = "Iosevka 12";
      };
    };

    home.packages = with pkgs; [ libnotify ];
  };

}
