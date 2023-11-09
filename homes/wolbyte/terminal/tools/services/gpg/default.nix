{
  osConfig,
  config,
  lib,
  ...
}: let
  sys = osConfig.wb.system;
in {
  services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor =
        if sys.video.enable
        then "gnome3" # requires services.dbus.packages = [pkgs.gcr]
        else "curses";
      enableSshSupport = true;
      defaultCacheTtl = 1209600;
      defaultCacheTtlSsh = 1209600;
      maxCacheTtl = 1209600;
      maxCacheTtlSsh = 1209600;

      # TODO: add zsh
    };
  };

  programs = {
    gpg = {
      enable = true;
      homedir = "${config.xdg.configHome}/gnupg";
    };
  };
}
