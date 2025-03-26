{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  inherit (config.wix) host;

  commonFonts = [
    "Iosevka Nerd Font"
    "Vazirmatn"
    "Noto Sans CJK"
    "Noto Color Emoji"
  ];

  monospaceFonts = [ "Iosevka Nerd Font" ];

  sansSerifFonts = [ "Lexend" ];

  serifFonts = [ "Noto Serif" ];

  emojiFonts = [ "Noto Color Emoji" ];
in
{
  config = mkIf host.enableDesktopFeatures {
    fonts = {
      enableDefaultPackages = true;

      fontDir = {
        enable = true;

        decompressFonts = true;
      };

      fontconfig = {
        enable = true;

        defaultFonts = {
          monospace = monospaceFonts ++ commonFonts;

          sansSerif = sansSerifFonts ++ commonFonts;

          serif = serifFonts ++ commonFonts;

          emoji = emojiFonts ++ commonFonts;
        };
      };

      packages = with pkgs; [
        corefonts # MS fonts
        vazir-fonts # Persian font

        lexend
        noto-fonts
        noto-fonts-cjk-sans
        roboto

        material-icons
        material-design-icons
        noto-fonts-emoji

        # Nerd fonts
        nerd-fonts.fira-code
        nerd-fonts.iosevka
        nerd-fonts.jetbrains-mono
      ];
    };
  };
}
