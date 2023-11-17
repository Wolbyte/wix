{config, ...}: let
  inherit (config.colorscheme) colors;
in {
  services.dunst = {
    enable = true;

    iconTheme = {
      inherit (config.gtk.iconTheme) name package;
    };

    settings = {
      global = {
        font = "Iosevka 12";

        height = 400;
        width = 350;
        corner_radius = 10;
        max_icon_size = 128;
        frame_width = 2;
        frame_color = "#${colors.base0D}";
        separator_color = "frame";
        alignment = "left";
        vertical_alignment = "center";
      };

      urgency_low = {
        timeout = 3;
        background = "#${colors.base00}";
        foreground = "#${colors.base0A}";
      };

      urgency_normal = {
        timeout = 6;
        background = "#${colors.base00}";
        foreground = "#${colors.base05}";
      };

      urgency_critical = {
        timeout = 0;
        background = "#${colors.base00}";
        foreground = "#${colors.base08}";
      };

      spotify = {
        appname = "Spotify";
        alignment = "center";
      };
    };
  };
}
