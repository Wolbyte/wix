{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.displayServers.x11;
in {
  options.wb.displayServers.x11 = {
    enable = mkEnableOption "x11";

    xprofile = {
      enable = mkEnableOption "xprofile management";
      config = mkOpt types.lines "" "Lines to put in `$HOME/.xprofile`.";
    };
  };

  config = mkIf cfg.enable {
    programs.dconf.enable = true;

    user.packages = with pkgs; [
      feh
      xclip
      xsel
    ];

    wb = {
      displayServer = "x11";
      services.dunst.enable = true;
    };

    hm.home.file.".xprofile" = mkIf cfg.xprofile.enable {
      text = cfg.xprofile.config;
    };
  };
}
