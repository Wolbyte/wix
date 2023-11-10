{
  pkgs,
  config,
  lib,
  osConfig,
  ...
}:
with lib;
with lib.wb; let
  inherit (osConfig.wb) device;
  cfg = osConfig.wb.theme;

  acceptedTypes = ["desktop" "hybrid"];
in {
  config = mkIf (builtins.elem device.profile acceptedTypes) {
    xdg.systemDirs.data = let
      schema = pkgs.gsettings-desktop-schemas;
    in ["${schema}/share/gsettings-schemas/${schema.name}"];

    home = {
      packages = with pkgs; [
        glib
        cfg.gtk.theme.package
        cfg.gtk.iconTheme.package
      ];

      sessionVariables = {
        GTK_THEME = "${cfg.gtk.theme.name}";

        GTK_USE_PORTAL = toString (boolToNum cfg.gtk.usePortal);
      };
    };

    gtk = {
      enable = true;

      theme = {
        inherit (cfg.gtk.theme) name package;
      };

      iconTheme = {
        inherit (cfg.gtk.iconTheme) name package;
      };

      font = {
        inherit (cfg.gtk.font) name size;
      };

      gtk2 = {
        configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
        extraConfig = ''
          gtk-xft-antialias=1
          gtk-xft-hinting=1
          gtk-xft-hintstyle="hintslight"
          gtk-xft-rgba="rgb"
        '';
      };

      gtk3.extraConfig = {
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-xft-rgba = "rgb";
        gtk-application-prefer-dark-theme = 1;
      };

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };
}
