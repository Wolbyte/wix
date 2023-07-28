{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.displayManagers.sddm;
in {
  options.wb.displayManagers.sddm = {
    enable = mkEnableOption "sddm";

    theme = {
      name = defaultOpts.mkStr "rose-pine" "The sddm theme name.";

      package = mkPackageOpt "sddm theme package to install." pkgs.wb.sddm-rose-pine-theme;
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;

      displayManager.sddm = {
        enable = true;

        theme = cfg.theme.name;
        settings = {
          Theme.CursorTheme = config.wb.gtk.cursorTheme.name;
        };
      };
    };

    environment.systemPackages = [cfg.theme.package];
  };
}
