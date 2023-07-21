{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.qt;
in {
  options.wb.qt = {
    enable = mkEnableOption "qt";

    theme = {
      name = defaultOpts.mkStr "Catppuccin-Mocha-Mauve" "Kvantum theme name.";

      package = mkPackageOpt "kvantum theme" (pkgs.catppuccin-kvantum.override {
        accent = "Mauve";
        variant = "Mocha";
      });
    };
  };

  config = mkIf cfg.enable (mkMerge
    [
      {
        user.packages = with pkgs; [
          libsForQt5.qtstyleplugin-kvantum
          qt5ct
          cfg.theme.package
        ];

        env.QT_QPA_PLATFORMTHEME = "qt5ct";

        hm.xdg.configFile = {
          "qt5ct/qt5ct.conf".source = (pkgs.formats.ini {}).generate "qt5ct.conf" {
            Appearance = {
              icon_theme = config.wb.gtk.iconTheme.name;
              style = "kvantum-dark";
            };
          };

          "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
            General.theme = cfg.theme.name;
          };

          "Kvantum/${cfg.theme.name}".source = "${cfg.theme.package}/share/Kvantum/${cfg.theme.name}";
        };
      }
      (mkIf (config.wb.displayServer == "wayland") {
        env = {
          QT_QPA_PLATFORM = "wayland";
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        };
        user.packages = with pkgs; [
          qt5.qtwayland
          qt6.qtwayland
        ];
      })
    ]);
}
