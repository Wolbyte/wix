{
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.programs.term.kitty;
in {
  options.wb.programs.term.kitty = {
    enable = mkEnableOption "kitty";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      hm.programs.kitty = {
        enable = true;

        settings = {
          scrollback_lines = 4000;
          scrollback_pager_history_size = 2048;
          window_padding_width = 15;
          background_opacity = "0.8";
        };
      };
    }

    (mkIf config.wb.fonts.enable {
      hm.programs.kitty.font = {
        name = config.wb.fonts.monospace.family;
        size = 12;
      };
    })
  ]);
}
