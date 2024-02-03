{
  pkgs,
  config,
  lib,
  osConfig,
  ...
}:
with lib;
with lib.wb; let
  inherit (osConfig.wb) device env system;
  inherit (config.colorscheme) palette;

  acceptedTypes = ["desktop" "hybrid"];

  ewwPackage =
    if env.isWayland
    then pkgs.eww-wayland
    else pkgs.eww;
in {
  config = mkIf (builtins.elem device.profile acceptedTypes && system.video.enable) {
    #TODO: Revamp eww bar & come up with a service based solution
    home.packages = [ewwPackage];

    xdg.configFile = {
      "eww" = {
        recursive = true;
        source = ./config;
      };

      "eww/_colorscheme.scss" = {
        recursive = true;
        text = ''
          $base00: #${palette.base00};
          $base01: #${palette.base01};
          $base02: #${palette.base02};
          $base03: #${palette.base03};
          $base04: #${palette.base04};
          $base05: #${palette.base05};
          $base06: #${palette.base06};
          $base07: #${palette.base07};
          $base08: #${palette.base08};
          $base09: #${palette.base09};
          $base0A: #${palette.base0A};
          $base0B: #${palette.base0B};
          $base0C: #${palette.base0C};
          $base0D: #${palette.base0D};
          $base0E: #${palette.base0E};
          $base0F: #${palette.base0F};
        '';
      };
    };
  };
}
