{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.programs.fileBrowsers.thunar;
in {
  options.wb.programs.fileBrowsers.thunar = {
    enable = mkEnableOption "thunar";
  };

  config = mkIf cfg.enable {
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    };

    wb.services.tumbler.enable = true;
  };
}
