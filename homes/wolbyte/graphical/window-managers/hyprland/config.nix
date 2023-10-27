{
  pkgs,
  defaults,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      "$MOD" = "SUPER";

      input = {
        follow_mouse = 1;
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
  };

  home.packages = with pkgs; [kitty neovim];
}
