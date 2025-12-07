{
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  inherit (osConfig.wix) host;
in
with lib;
{
  config = mkIf (host.enableDesktopFeatures) {
    home.packages = with pkgs; [
      kdePackages.dolphin

      # makes MIME application detection work
      libsForQt5.kservice

      # images, pdf, blender files
      kdePackages.kdegraphics-thumbnailers
      # webp, tiff, tga, jp2 files
      kdePackages.qtimageformats
      # video files
      kdePackages.ffmpegthumbs
      # audio files
      kdePackages.taglib
      # appimage embedded icons
      libappimage
      # anything ico related
      icoutils
    ];
  };
}
