{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  inherit (config.wb) device;

  acceptedTypes = ["desktop" "hybrid"];

  isAccepted = builtins.elem device.profile acceptedTypes;
in {
  config = mkIf isAccepted {
    fonts = {
      enableDefaultPackages = false;

      fontDir = {
        enable = true;
        decompressFonts = true;
      };

      fontconfig = {
        enable = true;

        defaultFonts = let
          common = [
            "Iosevka Nerd Font"
            "Noto Sans CJK"
            "Noto Color Emoji"
          ];
        in {
          monospace = common;

          sansSerif =
            [
              "Vazirmatn"
              "Lexend"
            ]
            ++ common;

          serif =
            [
              "Vazirmatn"
              "Noto Serif"
            ]
            ++ common;

          emoji =
            [
              "Noto Color Emoji"
            ]
            ++ common;
        };
      };

      packages = with pkgs; [
        # Desktop fonts
        corefonts # MS Fonts
        vazir-fonts # Persian font
        lexend
        material-icons
        material-design-icons
        noto-fonts
        noto-fonts-cjk
        roboto

        # Emoji fonts
        noto-fonts-emoji

        # NerdFonts
        (nerdfonts.override {
          fonts = [
            "Iosevka"
            "JetBrainsMono"
            "FiraCode"
          ];
        })

        # NixOS default fonts
        dejavu_fonts
        freefont_ttf
        gyre-fonts
        liberation_ttf
        unifont
      ];
    };
  };
}
