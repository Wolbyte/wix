{
  defaults,
  config,
  lib,
  ...
}:
with lib; let
  inherit (config.colorscheme) colors;

  pointer = config.home.pointerCursor;
in {
  wayland.windowManager.hyprland = {
    settings = {
      "$MOD" = "SUPER";

      exec-once = [
        "hyprctl setcursor ${pointer.name} ${toString pointer.size}"
      ];

      input = {
        follow_mouse = 1;
      };

      general = {
        "col.active_border" = "0xff${colors.base0C}";
        "col.inactive_border" = "0xff${colors.base02}";
      };

      group = {
        "col.border_active" = "0xff${colors.base0B}";
        "col.border_inactive" = "0xff${colors.base04}";

        groupbar = {
          text_color = "0xff${colors.base05}";
          gradients = false;
          render_titles = false;
          scrolling = true;
          "col.active" = "0xff${colors.base0B}";
          "col.inactive" = "0xff${colors.base04}";
        };
      };

      decoration = {
        rounding = 10;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          new_optimizations = true;
        };
      };

      bind = [
        "$MODSHIFT, E, exit"

        "$MOD, RETURN, exec, ${defaults.terminal}"

        # Window manipulation
        "$MOD, Q, killactive"
        "$MOD, T, togglegroup"
        "$MOD, G, changegroupactive"
        "$MOD, V, togglefloating"
        "$MOD, P, pseudo"
        "$MOD, F, fullscreen"

        # Window movement
        "$MODSHIFT, H, movewindow, l"
        "$MODSHIFT, L, movewindow, r"
        "$MODSHIFT, K, movewindow, u"
        "$MODSHIFT, J, movewindow, d"

        # Focus controls
        "$MOD, H, movefocus, l"
        "$MOD, L, movefocus, r"
        "$MOD, K, movefocus, u"
        "$MOD, J, movefocus, d"
      ];

      bindm = [
        "$MOD,mouse:272,movewindow"
        "$MOD,mouse:273,resizewindow"
      ];
    };

    extraConfig = with builtins; ''
      ${
        concatStringsSep "\n"
        (genList (
            x: let
              ws = toString (
                x + 1 - (((x + 1) / 10) * 10)
              );
            in ''
              bind = $MOD, ${ws}, workspace, ${toString (x + 1)}
              bind = $MODSHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
            ''
          )
          10)
      }
    '';
  };
}
