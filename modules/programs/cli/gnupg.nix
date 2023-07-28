{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.programs.cli.gnupg;

  pinentry =
    if config.wb.gtk.enable
    then {
      packages = [pkgs.pinentry-gnome pkgs.gcr];
      name = "gnome3";
    }
    else {
      packages = [pkgs.pinentry-curses];
      name = "curses";
    };
in {
  options.wb.programs.cli.gnupg = {
    enable = mkEnableOption "gnupg";

    cacheTTL = defaultOpts.mkInt 3600 "Gnupg cache TTL.";
  };

  config = mkIf cfg.enable {
    environment.variables.GNUPGHOME = "$XDG_CONFIG_HOME/gnupg";

    user.packages = pinentry.packages;

    programs.gnupg.agent = {
      enable = true;
      pinentryFlavor = pinentry.name;
    };
  };
}
