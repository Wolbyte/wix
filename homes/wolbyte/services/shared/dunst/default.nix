{config, ...}: let
  inherit (config.colorscheme) palette;
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
        frame_color = "#${palette.base0D}";
        separator_color = "frame";
        alignment = "left";
        vertical_alignment = "center";
      };

      urgency_low = {
        timeout = 3;
        background = "#${palette.base00}";
        foreground = "#${palette.base0A}";
      };

      urgency_normal = {
        timeout = 6;
        background = "#${palette.base00}";
        foreground = "#${palette.base05}";
      };

      urgency_critical = {
        timeout = 0;
        background = "#${palette.base00}";
        foreground = "#${palette.base08}";
      };

      spotify = {
        appname = "Spotify";
        alignment = "center";
      };
    };
  };
}
