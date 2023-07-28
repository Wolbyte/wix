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
  };
}
