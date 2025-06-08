{
  pkgs,
  config,
  osConfig,
  ...
}:
let
  inherit (osConfig.wix) host;
in
{
  services.gpg-agent = {
    enable = true;

    pinentry.package =
      if host.displayServer != null then pkgs.pinentry-gnome3 else pkgs.pinentry-curses;

    enableSshSupport = true;

    enableZshIntegration = config.programs.zsh.enable;
  };

  programs.gpg = {
    enable = true;

    homedir = "${config.xdg.configHome}/gnupg";
  };
}
