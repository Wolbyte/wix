{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.services.dunst;
  colorscheme = config.colorScheme;
in {
  options.wb.services.dunst = {
    enable = mkEnableOption "dunst";

    package = mkPackageOpt "dunst" pkgs.dunst;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      cfg.package
      libnotify
    ];

    hm.services.dunst = {
      enable = true;

      settings = {
        global = {
          font = "${config.wb.fonts.regular.family} 12";
          height = 400;
          width = 350;
          corner_radius = 10;
          max_icon_size = 128;
          frame_width = 2;
          frame_color = "#${colorscheme.colors.base0D}";
          separator_color = "frame";
          alignment = "left";
        };

        urgency_low = {
          background = "#${colorscheme.colors.base00}";
          foreground = "#${colorscheme.colors.base0A}";
        };

        urgency_normal = {
          background = "#${colorscheme.colors.base00}";
          foreground = "#${colorscheme.colors.base05}";
        };

        urgency_critical = {
          background = "#${colorscheme.colors.base00}";
          foreground = "#${colorscheme.colors.base08}";
        };

        spotify = {
          appname = "Spotify";
          alignment = "center";
        };
      };
    };
  };
}
