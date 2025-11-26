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
      postman
    ];
  };
}
