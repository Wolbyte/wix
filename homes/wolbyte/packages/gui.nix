{
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib;
let
  inherit (osConfig.wix) host;

  sharedPacakges = with pkgs; [
    kdePackages.ark
    kdePackages.kio
    kdePackages.kio-extras
    kdePackages.kimageformats
    pavucontrol
    telegram-desktop
  ];
in
{
  config = mkIf (host.enableDesktopFeatures) {
    home.packages = mkMerge [
      sharedPacakges
    ];
  };
}
