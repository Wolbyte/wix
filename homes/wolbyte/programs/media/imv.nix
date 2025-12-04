{ lib, osConfig, ... }:
with lib;
let
  inherit (osConfig.wix) host;
in
{
  config = mkIf host.enableDesktopFeatures {
    programs.imv = {
      enable = true;
    };
  };
}
