{
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.desktopEnvironments.hyprland;
  colorscheme = config.colorScheme;
in {
  options.wb.desktopEnvironments.hyprland = {
    enable = mkEnableOption "hyprland";
  };

  config = mkIf cfg.enable {
    wb.displayServers.wayland.enable = true;

    wb.services.polkit.enable = true;

    programs.hyprland.enable = true;

    hm.wayland.windowManager.hyprland = {
      enable = true;
      nvidiaPatches = config.wb.hardware.gpu.vendor == "nvidia";
      extraConfig = let
        modifier = "SUPER";
        wallpaperCmd = with config.wb;
          if wallpaper.preferredType == "live"
          then "mpvpaper -o 'no-audio loop' '*' ${wallpaper.live.path}"
          else "swaybg -i ${wallpaper.normal.path} --mode fill";
      in ''
        exec-once = ${config.wb.services.polkit.agent.executablePath}
        exec-once = ${wallpaperCmd}

        input {
          kb_layout = ${config.services.xserver.layout}
          kb_options = ${config.services.xserver.xkbOptions}

          follow_mouse = 1

          sensitivity = 0
        }

        general {
          col.active_border = 0xff${colorscheme.colors.base0C}
          col.inactive_border = 0xff${colorscheme.colors.base02}
          col.group_border_active = 0xff${colorscheme.colors.base0B}
          col.group_border = 0xff${colorscheme.colors.base04}
        }

        decoration {
          rounding = 10
          blur = true
          blur_size = 3
          blur_passes = 1
          blur_new_optimizations = true
          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
        }

        animations {
          enabled = true
          bezier = myBezier, 0.05, 0.9, 0.1, 1.05
          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
        }

        dwindle {
         pseudotile = true
         preserve_split = true
        }

        master {
         new_is_master = true
        }

        $SUPER = ${modifier}
        $SUPER_SHIFT = ${modifier}_SHIFT
        $SUPER_ALT = ${modifier}_ALT
        $SUPER_CRTL = CTRL_${modifier}

        # Apps
        bind = $SUPER, Return, exec, kitty
        bind = $SUPER, D, exec, $LAUNCHER

        # WM
        bind = $SUPER, Q, killactive,
        bind = CTRL_ALT, Delete, exit,
        bind = $SUPER, F, fullscreen,
        bind = $SUPER, V, togglefloating,
        bind = $SUPER, P, pin,
        bind = $SUPER, T, togglesplit,
        bind = $SUPER_SHIFT, P, pseudo,
        bind = $SUPER_SHIFT, T, bringactivetotop,

        # Movement/Resize
        bind = $SUPER, h, movefocus, l
        bind = $SUPER, l, movefocus, r
        bind = $SUPER, k, movefocus, u
        bind = $SUPER, j, movefocus, d

        bind = $SUPER_SHIFT, h, movewindow, l
        bind = $SUPER_SHIFT, l, movewindow, r
        bind = $SUPER_SHIFT, k, movewindow, u
        bind = $SUPER_SHIFT, j, movewindow, d

        bind = $SUPER_CTRL, h, resizeactive, -50 0
        bind = $SUPER_CTRL, l, resizeactive, 50 0
        bind = $SUPER_CTRL, k, resizeactive, 0 -50
        bind = $SUPER_CTRL, j, resizeactive, 0 50

        # Cycle workspaces
        bind = $SUPER, bracketright, workspace, e+1
        bind = $SUPER, bracketleft, workspace, e-1

        # Move/resize windows with SUPER + LMB/RMB
        bindm = $SUPER, mouse:272, movewindow
        bindm = $SUPER, mouse:273, resizewindow

        # Media Control
        $MEDIA_CMD = playerctl --player spotify
        bind = $SUPER_CTRL, up, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
        bind = $SUPER_CTRL, down, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
        bind = $SUPER_CTRL, Prior, exec, $MEDIA_CMD next
        bind = $SUPER_CTRL, Next, exec, $MEDIA_CMD previous
        bind = $SUPER_CTRL, Pause, exec, $MEDIA_CMD play-pause

        # Workspaces
        ${
          concatStrings (
            imap1 (i: v: ''
              bind = $SUPER, ${v}, workspace, ${toString i}
              bind = $SUPER_SHIFT, ${v}, movetoworkspace, ${toString i}
            '')
            (
              (builtins.genList (x:
                if x == 9
                then "0"
                else toString (x + 1))
              10)
              ++ (builtins.genList (x: "f" + toString (x + 1)) 12)
            )
          )
        }
      '';
    };
  };
}
