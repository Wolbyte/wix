{
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.programs.cli.btop;
in {
  options.wb.programs.cli.btop = {
    enable = mkEnableOption "btop";
  };

  config = mkIf cfg.enable {
    hm.programs.btop = {
      enable = true;

      settings = {
        color_theme = "TTY";
        vim_keys = true;
      };
    };
  };
}
