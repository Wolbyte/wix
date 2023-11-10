{
  pkgs,
  lib,
  ...
}:
with lib.wb; {
  imports = [
    ./gtk.nix
    ./qt.nix
  ];

  options.wb.theme = {
    forceGTKTheme = defaultOpts.mkBool false "Force apps to use the GTK theme.";

    useKvantum = defaultOpts.mkBool false "Use kvantum engine to theme QT apps.";

    cursor = {
      package = mkPackageOpt "cursor theme" pkgs.catppuccin-cursors.mochaDark;

      name = defaultOpts.mkStr "Catppuccin-Mocha-Dark-Cursors" "The cursortheme name.";

      size = defaultOpts.mkInt 24 "The size of the cursor";
    };
  };
}
