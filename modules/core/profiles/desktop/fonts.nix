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

      fontconfig = {
        enable = true;

        defaultFonts = {
          monospace = [
            "Iosevka Term"
            "Iosevka Term Nerd Font Complete Mono"
            "Iosevka Nerd Font"
            "Noto Color Emoji"
          ];

          sansSerif = [
            "Lexend"
            "Noto Color Emoji"
          ];

          serif = [
            "Noto Serif"
            "Noto Color Emoji"
          ];

          emoji = [
            "Noto Color Emoji"
          ];
        };
      };

      fontDir = {
        enable = true;
        decompressFonts = true;
      };

      packages = with pkgs; [
        corefonts

        iosevka-bin

        roboto

        material-icons
        material-design-icons

        lexend

        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji

        (nerdfonts.override {fonts = ["Iosevka" "JetBrainsMono" "FiraCode"];})
      ];
    };
  };
}
