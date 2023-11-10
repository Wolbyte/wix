{
  pkgs,
  inputs,
  lib,
  ...
}:
with lib;
with lib.wb; let
  inherit (inputs) nix-colors;
  nix-colors-lib = nix-colors.lib.contrib {inherit pkgs;};
  colorscheme = nix-colors.colorSchemes.rose-pine;
in {
  options.wb.theme.gtk = {
    enable = defaultOpts.mkBool false "Enable GTK theming.";

    usePortal = defaultOpts.mkBool false "Use native desktop portal for filepickers.";

    theme = {
      name = defaultOpts.mkStr colorscheme.slug "The name of the GTK theme.";

      package = mkPackageOpt "GTK theme" (nix-colors-lib.gtkThemeFromScheme {
        scheme = colorscheme;
      });
    };

    iconTheme = {
      name = defaultOpts.mkStr "rose-pine" "The name of the GTK icon theme.";

      package = mkPackageOpt "GTK icon theme" pkgs.rose-pine-icon-theme;
    };

    font = {
      name = defaultOpts.mkStr "Lexend" "The name of the font to be used in GTK apps.";

      size = defaultOpts.mkInt 14 "The size of the font.";
    };
  };
}
