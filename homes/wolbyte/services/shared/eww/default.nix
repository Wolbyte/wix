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
  inherit (config.colorscheme) colors;

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
          $base00: #${colors.base00};
          $base01: #${colors.base01};
          $base02: #${colors.base02};
          $base03: #${colors.base03};
          $base04: #${colors.base04};
          $base05: #${colors.base05};
          $base06: #${colors.base06};
          $base07: #${colors.base07};
          $base08: #${colors.base08};
          $base09: #${colors.base09};
          $base0A: #${colors.base0A};
          $base0B: #${colors.base0B};
          $base0C: #${colors.base0C};
          $base0D: #${colors.base0D};
          $base0E: #${colors.base0E};
          $base0F: #${colors.base0F};
        '';
      };
    };
  };
}
