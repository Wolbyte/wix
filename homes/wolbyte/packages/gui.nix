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
    libsForQt5.ark
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
