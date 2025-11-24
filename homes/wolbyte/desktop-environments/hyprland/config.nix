{ config, ... }:
let
  inherit (config.wix) userPreferences;
in
{
  "$mainMod" = "SUPER";
  "$terminal" = userPreferences.defaultPrograms.terminalEmulator;
  "$fileManager" = "dolphin";
  "$menu" = "rofi -show drun";
  "$calculator" = "rofi -show calc";
  "$emojiPicker" = "rofi -show emoji";
  "$screenshotMenu" = "wb-screenshot";

  monitor = ",highres@highrr,auto,auto,vrr,1";

  exec-once = [
    "hyprctl setcursor ${config.home.pointerCursor.name} ${builtins.toString config.home.pointerCursor.size}"

    # TODO: use wallnix
    "swaybg -i $XDG_PICTURES_DIR/wallpapers/bb-maria-keibleh.jpg"
  ];

  input = {
    kb_layout = "us,ir";
    kb_options = "grp:win_space_toggle,caps:swapescape";

    follow_mouse = 1;
  };

  general = {
    layout = "dwindle";
  };

  decoration = {
    rounding = 10;

    blur = {
      enabled = true;
      size = 1;
      passes = 2;
      ignore_opacity = true;
      new_optimizations = true;
      xray = true;
    };
  };

  animations = {
    enabled = true;

    bezier = [
      "smoothIn, 0.25, 1, 0.5, 1"
      "easeInOutQuart, 0.77,0,0.18,1"
      "easeInOutQuint, 0.86,0,0.07,1"
      "easeInOutExpo, 1,0,0,1"
    ];

    animation = [
      "windows, 1, 4, easeInOutQuart, slide"
      "layers, 1, 4, easeInOutQuart, fade"
      "windowsOut, 1, 4, easeInOutQuint, slide"
      "border, 1, 10, default"
      "fade, 1, 10, smoothIn"
      "fadeDim, 1, 10, smoothIn"
      "workspaces, 1, 4.5, easeInOutExpo, slide"
    ];
  };

  dwindle = {
    pseudotile = true;
    preserve_split = true;
  };

  master = {
    new_status = "master";
  };

  misc = {
    disable_hyprland_logo = true;
    disable_splash_rendering = true;
  };

  bind = [
    "$mainMod, RETURN, exec, kitty"
    "$mainMod, Q, killactive,"
    "$mainMod, M, exit,"
    "$mainMod, E, exec, $fileManager"

    # Launchers
    "$mainMod, D, exec, $menu"
    "$mainMod, S, exec, $screenshotMenu"
    "$mainMod, Print, exec, grimblast save output -n -t png \"$XDG_PICTURES_DIR/screenshots/$(date +%Y-%m-%d-%I-%M-%S).png\""
    "$mainMod SHIFT, S, exec, grimblast -f copy area"
    "$mainMod, equal, exec, $calculator"
    "$mainMod, period, exec, $emojiPicker"

    # Window manipulation
    "$mainMod, Q, killactive"
    "$mainMod, T, togglegroup"
    "$mainMod SHIFT, T, togglesplit"
    "$mainMod CTRL, T, bringactivetotop"
    "$mainMod, G, changegroupactive"
    "$mainMod, V, togglefloating"
    "$mainMod, P, pseudo"
    "$mainMod SHIFT, P, pin"
    "$mainMod, F, fullscreen"

    # Window movement
    "$mainMod SHIFT, H, movewindow, l"
    "$mainMod SHIFT, L, movewindow, r"
    "$mainMod SHIFT, K, movewindow, u"
    "$mainMod SHIFT, J, movewindow, d"

    # Focus controls
    "$mainMod, H, movefocus, l"
    "$mainMod, L, movefocus, r"
    "$mainMod, K, movefocus, u"
    "$mainMod, J, movefocus, d"

    # Scroll through workspaces
    "$mainMod, mouse_down, workspace, e+1"
    "$mainMod, mouse_up, workspace, e-1"
    "$mainMod, bracketright, workspace, e+1"
    "$mainMod, bracketleft, workspace, e-1"

    # Special workspace
    "$mainMod, Z, togglespecialworkspace, magic"
    "$mainMod SHIFT, Z, movetoworkspace, special:magic"
  ]
  ++ (
    # workspaces
    # binds $mainMod + [shift +] {1..0} to [move to] workspace {1..10}
    builtins.concatLists (
      builtins.genList (
        i:
        let
          ws = i + 1;
        in
        [
          "$mainMod, code:1${toString i}, workspace, ${toString ws}"
          "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
      ) 10
    )
  );

  binde = [
    # Volume Control
    ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
    ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
    "$mainMod CTRL, up, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
    "$mainMod CTRL, down, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"

    # Window resize
    "$mainMod CTRL, H, resizeactive, -50 0"
    "$mainMod CTRL, L, resizeactive, 50 0"
    "$mainMod CTRL, K, resizeactive, 0 -50"
    "$mainMod CTRL, J, resizeactive, 0 50"

    # Floating window movement
    "$mainMod CTRL SHIFT, H, moveactive, -50 0"
    "$mainMod CTRL SHIFT, L, moveactive, 50 0"
    "$mainMod CTRL SHIFT, K, moveactive, 0 -50"
    "$mainMod CTRL SHIFT, J, moveactive, 0 50"
  ];

  bindl = [
    ",XF86AudioNext, exec, playerctl next"
    ",XF86AudioPrev, exec, playerctl previous"
    ",XF86AudioPlay, exec, playerctl play-pause"
    "$mainMod CTRL, PRIOR, exec, playerctl next"
    "$mainMod CTRL, NEXT,  exec, playerctl previous"
    "$mainMod CTRL, PAUSE, exec, playerctl play-pause"
  ];

  bindm = [
    # Move/resize windows with mainMod + LMB/RMB and dragging
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];

  windowrule = [
    "match:class .*, suppress_event maximize"

    # Disable blur for menus
    "match:class ^()$, match:title ^()$, no_blur on"

    # Floats
    "match:title ^(Media viewer)$, float on, animation popin, no_blur on" # Telegram media viewer
    "match:class ^(org.pulseaudio.pavucontrol)$, float on, size 800 600, center on, animation popin" # Volume manager
    "match:title ^(Bluetooth Devices)$, float on, size 800 600, center on, animation popin" # blueman-manager
  ];

  layerrule = [
    "match:namespace notifications, animation slide"
    "match:namespace rofi, animation slide"
  ];
}
