{
  defaults,
  config,
  lib,
  osConfig,
  ...
}:
with lib; let
  inherit (config.colorscheme) palette;

  pointer = config.home.pointerCursor;
in {
  wayland.windowManager.hyprland = {
    settings = {
      "$MOD" = "SUPER";

      exec-once = [
        "hyprctl setcursor ${pointer.name} ${toString pointer.size}"
        "eww open bar"
      ];

      input = {
        kb_layout = osConfig.services.xserver.xkb.layout;
        kb_options = osConfig.services.xserver.xkb.options;
        follow_mouse = 1;
        numlock_by_default = true;
      };

      decoration = {
        rounding = 10;

        blur = {
          enabled = true;
          size = 5;
          passes = 2;
          ignore_opacity = true;
          new_optimizations = 1;
          xray = true;
        };
      };

      general = {
        "col.active_border" = "0xff${palette.base0C}";
        "col.inactive_border" = "0xff${palette.base02}";
      };

      group = {
        insert_after_current = true;

        focus_removed_window = true;

        "col.border_active" = "0xff${palette.base0B}";
        "col.border_inactive" = "0xff${palette.base04}";

        groupbar = {
          text_color = "0xff${palette.base05}";
          gradients = false;
          render_titles = false;
          scrolling = true;
          "col.active" = "0xff${palette.base0B}";
          "col.inactive" = "0xff${palette.base04}";
        };
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;

        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        disable_autoreload = true;
      };

      animations = {
        enabled = true;

        bezier = [
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
          "overshot, 0.4,0.8,0.2,1.2"
          "ws,0.48,0,0.61,1.1"
        ];

        animation = [
          "windows, 1, 4, overshot, slide"
          "windowsOut, 1, 4, smoothOut, slide"
          "border, 1, 10, default"

          "fade, 1, 10, smoothIn"
          "fadeDim, 1, 10, smoothIn"
          "workspaces, 1, 4, ws, slide"
        ];
      };

      dwindle = {
        pseudotile = false;
        preserve_split = "yes";
        no_gaps_when_only = false;
      };

      bind = [
        "$MODSHIFT, E, exit"

        "$MOD, RETURN, exec, ${defaults.terminal}"

        "$MOD, D, exec, pkill rofi || rofi -show drun"
        "$MOD, equal, exec, pkill rofi || rofi -show calc"
        "$MOD, period, exec, pkill rofi || rofi -show emoji"
        "$MOD, S, exec, pkill rofi || rofi-screenshot"

        # Window manipulation
        "$MOD, Q, killactive"
        "$MOD, T, togglegroup"
        "$MODSHIFT, T, togglesplit"
        "$MODCTRL, T, bringactivetotop"
        "$MOD, G, changegroupactive"
        "$MOD, V, togglefloating"
        "$MOD, P, pseudo"
        "$MODSHIFT, P, pin"
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

        # Workspace controls
        "$MOD, mouse_up, workspace, e-1"
        "$MOD, mouse_down, workspace, e+1"
        "$MOD, bracketright, workspace, e+1"
        "$MOD, bracketleft, workspace, e-1"
      ];

      # Keybinds that will activate even while input inhibition is active
      bindl = [
        # Media Control
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioPlay, exec, playerctl play-pause"
        "$MODCTRL, PRIOR, exec, playerctl next"
        "$MODCTRL, NEXT,  exec, playerctl previous"
        "$MODCTRL, PAUSE, exec, playerctl play-pause"
      ];

      # Keybinds that can be repeated
      binde = [
        # Volume Control
        ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        "$MODCTRL, up, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        "$MODCTRL, down, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"

        # Window resize
        "$MODCTRL, H, resizeactive, -50 0"
        "$MODCTRL, L, resizeactive, 50 0"
        "$MODCTRL, K, resizeactive, 0 -50"
        "$MODCTRL, J, resizeactive, 0 50"

        # Floating window movement
        "$MODCTRLSHIFT, H, moveactive, -50 0"
        "$MODCTRLSHIFT, L, moveactive, 50 0"
        "$MODCTRLSHIFT, K, moveactive, 0 -50"
        "$MODCTRLSHIFT, J, moveactive, 0 50"
      ];

      bindm = [
        "$MOD,mouse:272,movewindow"
        "$MOD,mouse:273,resizewindow"
      ];

      windowrulev2 = [
        # Floats
        "float,class:udiskie"
        "float, title:^(Media viewer)$" # Telegram Media Viewer
        "float, class:^(imv)$"

        # pavucontrol
        "float,class:pavucontrol"
        "float,title:^(Volume Control)$"
        "size 41.6% 55.5%,title:^(Volume Control)$"
        "move 58% 44%,title:^(Volume Control)$"

        # Idle Inhibition
        "idleinhibit focus, class:^(mpv)$"
        "idleinhibit fullscreen, class:^(firefox)$"

        # Pin PIP window
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"

        # Hide screen sharing indicators
        "float,title:^(Firefox — Sharing Indicator)$"
        "move 0 0,title:^(Firefox — Sharing Indicator)$"
        "workspace special silent, title:^(Firefox — Sharing Indicator)$"
        "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"
      ];
    };

    extraConfig = with builtins; ''
      # workspace binds
      # binds asterisk to special workspace
      monitor=HDMI-A-1,preferred,1920x1080,1

      # this one popped out of nowhere
      monitor=Unknown-1,disable

      bind = $MOD, KP_Multiply, togglespecialworkspace
      bind = $MODSHIFT, KP_Multiply, movetoworkspace, special
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
