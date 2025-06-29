{ pkgs, config, ... }:
let
  size = 24;
in
{
  home.pointerCursor = {
    enable = true;

    package = pkgs.rose-pine-cursor;

    name = "BreezeX-RosePine-Linux";

    inherit size;

    hyprcursor = {
      enable = config.wayland.windowManager.hyprland.enable;

      inherit size;
    };

    gtk.enable = config.gtk.enable;
  };
}
