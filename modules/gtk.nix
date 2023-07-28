{
  pkgs,
  config,
  lib,
  nix-colors,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.gtk;
  nix-colors-lib = nix-colors.lib.contrib {inherit pkgs;};
in {
  options.wb.gtk = {
    enable = mkEnableOption "gtk";

    theme = {
      name = defaultOpts.mkStr config.colorScheme.slug "GTK theme name.";

      package = mkPackageOpt "GTK theme" (nix-colors-lib.gtkThemeFromScheme {
        scheme = config.colorScheme;
      });
    };

    iconTheme = {
      name = defaultOpts.mkStr "rose-pine" "Icon theme name.";

      package = mkPackageOpt "GTK icon theme" pkgs.rose-pine-icon-theme;
    };

    cursorTheme = {
      name = defaultOpts.mkStr "Catppuccin-Mocha-Dark-Cursors" "The name of the cursor theme to use.";

      package = mkPackageOpt "cursor theme" pkgs.catppuccin-cursors.mochaDark;

      size = defaultOpts.mkInt 24 "Cursor size.";

      x11 = defaultOpts.mkBool true "Whether to apply the cursor theme for x11.";
    };
  };

  config = mkIf cfg.enable {
    env.XCURSOR_SIZE = toString cfg.cursorTheme.size;
    hm.home.pointerCursor = {
      inherit
        (cfg.cursorTheme)
        name
        package
        size
        ;
      gtk.enable = true;
      x11.enable = cfg.cursorTheme.x11;
    };
    hm.gtk = {
      enable = true;

      inherit (cfg) theme iconTheme;
    };
  };
}
