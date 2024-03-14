{
  osConfig,
  config,
  ...
}: let
  sys = osConfig.wb.system;
in {
  services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor =
        if sys.video.enable
        then "gnome2" # requires services.dbus.packages = [pkgs.gcr]
        else "curses";
      enableSshSupport = true;
      defaultCacheTtl = 1209600;
      defaultCacheTtlSsh = 1209600;
      maxCacheTtl = 1209600;
      maxCacheTtlSsh = 1209600;

      enableZshIntegration = true;
    };
  };

  programs = {
    gpg = {
      enable = true;
      homedir = "${config.xdg.configHome}/gnupg";
    };
  };
}
