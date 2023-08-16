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
in {
  options.wb.programs.desktop.eww = {
    enable = mkEnableOption "eww";

    package =
      mkPackageOpt "eww"
      (
        if config.wb.displayServer == "x11"
        then pkgs.eww
        else pkgs.eww-wayland
      );
  };

  config = mkIf cfg.enable {
    user.packages = [cfg.package];

    hm.xdg.configFile."eww" = {
      recursive = true;
      source = ./_config;
    };

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
