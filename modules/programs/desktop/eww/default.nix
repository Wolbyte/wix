{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.programs.desktop.eww;
  colorscheme = config.colorScheme;
  isWayland = config.wb.displayServer == "wayland";
in {
  options.wb.programs.desktop.eww = {
    enable = mkEnableOption "eww";

    package =
      mkPackageOpt "eww"
      (
        if isWayland
        then pkgs.eww-wayland
        else pkgs.eww
      );
  };

  config = mkIf cfg.enable {
    user.packages = [cfg.package];

    hm.xdg.configFile."eww" = {
      recursive = true;
      source = ./_config;
    };

    hm.xdg.configFile."eww/eww.yuck".text = ''
      (include "./widgets/workspaces.yuck")
      (include "./widgets/speaker.yuck")
      (include "./widgets/time.yuck")

      (defwidget bar-content []
        (centerbox :orientation "h"
          (workspaces)
          (box)
          (box
            :halign "end"
            :space-evenly false
            :spacing 5

            (speaker)
            (label :text "|")
            (time)
            (box)
          )
        )
      )

      (defwindow bar
        :monitor 0
        :class "bar"
        :geometry (geometry
                    :x "0"
                    :y "5px"
                    :width "98%"
                    :height "35px"
                    :anchor "top center"
                  )
        :stacking "bg"
        ${
        if (!isWayland)
        then ''
          :windowtype "dock"
          :reserve (struts :side "top" :distance "35px")
          :wm-ignore false
        ''
        else ''
          :exclusive true
        ''
      }
        (bar-content)
      )
    '';

    hm.xdg.configFile."eww/_colorscheme.scss" = {
      recursive = true;
      text = ''
        $base00: #${colorscheme.colors.base00};
        $base01: #${colorscheme.colors.base01};
        $base02: #${colorscheme.colors.base02};
        $base03: #${colorscheme.colors.base03};
        $base04: #${colorscheme.colors.base04};
        $base05: #${colorscheme.colors.base05};
        $base06: #${colorscheme.colors.base06};
        $base07: #${colorscheme.colors.base07};
        $base08: #${colorscheme.colors.base08};
        $base09: #${colorscheme.colors.base09};
        $base0A: #${colorscheme.colors.base0A};
        $base0B: #${colorscheme.colors.base0B};
        $base0C: #${colorscheme.colors.base0C};
        $base0D: #${colorscheme.colors.base0D};
        $base0E: #${colorscheme.colors.base0E};
        $base0F: #${colorscheme.colors.base0F};
      '';
    };
  };
}
