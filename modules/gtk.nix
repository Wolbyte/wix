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
  };

  config = mkIf cfg.enable {
    hm.gtk = {
      enable = true;

      inherit (cfg) theme iconTheme;
    };
  };
}
