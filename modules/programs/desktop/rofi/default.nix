{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.programs.desktop.rofi;
  colorscheme = config.colorScheme;
in {
  options.wb.programs.desktop.rofi = {
    enable = mkEnableOption "rofi";
  };

  config = mkIf cfg.enable {
    user.packages =
      if config.wb.displayServer == "wayland"
      then [pkgs.rofi-wayland]
      else [pkgs.rofi];

    env = {
      __WB_ROFI_LAUNCHER = "$XDG_CONFIG_HOME/rofi/launch.sh launchers 1";
      __WB_ROFI_SCREENSHOT = "$XDG_CONFIG_HOME/rofi/screenshot.sh";
    };

    hm.xdg.configFile."rofi/shared/fonts.rasi".text = ''
      * {
        font: "${config.wb.fonts.regular.family}";
      }
    '';

    hm.xdg.configFile."rofi/shared/colors.rasi".text = ''
      * {
        red:                         #${colorscheme.colors.base08};
        blue:                        #${colorscheme.colors.base0D};
        lightfg:                     #${colorscheme.colors.base06};
        lightbg:                     #${colorscheme.colors.base01};
        foreground:                  #${colorscheme.colors.base05};
        background:                  #${colorscheme.colors.base00};
        background-color:            #${colorscheme.colors.base00};
        separatorcolor:              @foreground;
        border-color:                @foreground;
        selected-normal-foreground:  @lightbg;
        selected-normal-background:  @lightfg;
        selected-active-foreground:  @background;
        selected-active-background:  @blue;
        selected-urgent-foreground:  @background;
        selected-urgent-background:  @red;
        normal-foreground:           @foreground;
        normal-background:           @background;
        active-foreground:           @blue;
        active-background:           @background;
        urgent-foreground:           @red;
        urgent-background:           @background;
        alternate-normal-foreground: @foreground;
        alternate-normal-background: @lightbg;
        alternate-active-foreground: @blue;
        alternate-active-background: @lightbg;
        alternate-urgent-foreground: @red;
        alternate-urgent-background: @lightbg;
        spacing:                     2;
      }
    '';

    hm.xdg.configFile."rofi" = {
      recursive = true;
      source = ./_config;
    };
  };
}
