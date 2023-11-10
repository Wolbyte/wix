{
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib; let
  inherit (osConfig.wb) device system;

  cfg = osConfig.wb.theme;

  acceptedTypes = ["desktop" "hybrid"];
in {
  config = mkIf (builtins.elem device.profile acceptedTypes && system.video.enable) {
    xdg.configFile = {
      "kdeglobals".source = cfg.qt.kdeglobals.source;

      "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
        General.theme = "catppuccin";
        Applications.catppuccin = ''
          qt5ct, org.kde.dolphin, org.kde.kalendar, org.qbittorrent.qBittorrent, hyprland-share-picker, dolphin-emu, Nextcloud, nextcloud, cantata, org.kde.kid3-qt
        '';
      };

      "Kvantum/catppuccin/catppuccin.kvconfig".source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Mocha-Mauve/Catppuccin-Mocha-Mauve.kvconfig";
        sha256 = "1hwb6j5xjkmnsi55c6hsdwcn8r4n4cisfbsfya68j4dq5nj0z3r6";
      };

      "Kvantum/catppuccin/catppuccin.svg".source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Mocha-Mauve/Catppuccin-Mocha-Mauve.svg";
        sha256 = "06w5nfp89v1zzzrxm38i77wpfrvbknfzjrrnsixw7r1ljk017ijh";
      };
    };

    qt = {
      enable = true;
      platformTheme = mkIf cfg.forceGTKTheme "gtk";
      style = mkIf (!cfg.forceGTKTheme) {
        inherit (cfg.qt.theme) name package;
      };
    };

    home.packages = with pkgs;
      [
        libsForQt5.qt5ct
        breeze-icons
        cfg.qt.theme.package
      ]
      ++ optionals cfg.useKvantum [
        qt6Packages.qtstyleplugin-kvantum
        libsForQt5.qtstyleplugin-kvantum
      ];

    home.sessionVariables = {
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";

      QT_QPA_PLATFORM = "wayland;xcb";

      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      # remain backwards compatible with qt5
      DISABLE_QT5_COMPAT = "0";

      CALIBRE_USE_DARK_PALETTE = "1";
    };
  };
}
