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
  config = mkIf (host.enableDesktopFeatures) {
    home.packages = [ pkgs.eww ];

    xdg.configFile."eww" = {
      source = ./config;
      recursive = true;
    };
  };
}
