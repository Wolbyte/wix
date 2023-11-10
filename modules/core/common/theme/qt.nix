{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.theme;
in {
  options.wb.theme.qt = {
    enable = defaultOpts.mkBool false "Enable QT theming.";

    theme = {
      name = defaultOpts.mkStr "Catppuccin-Mocha-dark" "The name of the QT theme.";

      package = mkPackageOpt "QT theme" (
        pkgs.catppuccin-kde.override {
          flavour = ["mocha"];
          accents = ["mauve"];
          winDecStyles = ["modern"];
        }
      );
    };

    kdeglobals.source = mkOpt types.path "${cfg.qt.theme.package}/share/color-schemes/CatppuccinMochaMauve.colors" "The source file for kdeglobals.";
  };
}
