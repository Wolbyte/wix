{
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib;
let
  inherit (osConfig.wix) host;
in
{
  config = mkIf host.enableDesktopFeatures {
    services.dunst = {
      enable = true;

      settings = {
        global = {
          font = "sans-serif 12";

          enable_posix_regex = true;

          gap_size = 3;
          origin = "bottom-right";
          offset = "(5,5)";

          corner_radius = 10;
          frame_width = 1;
          icon_corner_radius = 10;
          max_icon_size = 128;
          width = "(300,300)";

          background = "#191724";
          foreground = "#e0def4";
          highlight = "frame";
        };

        spotify = {
          appname = "Spotify";
          alignment = "center";
          icon_position = "top";
          frame_color = "#c4a7e7";
          format = ''<b><span foreground='#c4a7e7'>%s</span></b>\n<i>%b</i>'';
        };

        low_urgency = {
          msg_urgency = "low";
          frame_color = "#31748f";
          format = ''<b><span foreground='#31748f'>%s</span></b>\n%b'';
        };

        normal_urgency = {
          msg_urgency = "normal";
          frame_color = "#f6c177";
          format = ''<b><span foreground='#f6c177'>%s</span></b>\n%b'';
        };

        critical_urgency = {
          msg_urgency = "critical";
          frame_color = "#eb6f92";
          format = ''<b><span foreground='#eb6f92'>%s</span></b>\n%b'';
        };
      };
    };

    home.packages = with pkgs; [ libnotify ];
  };
}
