{
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.programs.term.kitty;
  inherit (config) colorscheme;
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

          # https://github.com/kdrag0n/base16-kitty
          foreground = "#${colorscheme.colors.base05}";
          background = "#${colorscheme.colors.base00}";
          selection_background = "#${colorscheme.colors.base05}";
          selection_foreground = "#${colorscheme.colors.base00}";
          url_color = "#${colorscheme.colors.base04}";
          cursor = "#${colorscheme.colors.base05}";
          active_border_color = "#${colorscheme.colors.base03}";
          inactive_border_color = "#${colorscheme.colors.base01}";
          active_tab_background = "#${colorscheme.colors.base00}";
          active_tab_foreground = "#${colorscheme.colors.base05}";
          inactive_tab_background = "#${colorscheme.colors.base01}";
          inactive_tab_foreground = "#${colorscheme.colors.base04}";
          tab_bar_background = "#${colorscheme.colors.base01}";

          color0 = "#${colorscheme.colors.base00}";
          color1 = "#${colorscheme.colors.base08}";
          color2 = "#${colorscheme.colors.base0B}";
          color3 = "#${colorscheme.colors.base0A}";
          color4 = "#${colorscheme.colors.base0D}";
          color5 = "#${colorscheme.colors.base0E}";
          color6 = "#${colorscheme.colors.base0C}";
          color7 = "#${colorscheme.colors.base05}";

          color8 = "#${colorscheme.colors.base03}";
          color9 = "#${colorscheme.colors.base09}";
          color10 = "#${colorscheme.colors.base01}";
          color11 = "#${colorscheme.colors.base02}";
          color12 = "#${colorscheme.colors.base04}";
          color13 = "#${colorscheme.colors.base06}";
          color14 = "#${colorscheme.colors.base0F}";
          color15 = "#${colorscheme.colors.base07}";
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
