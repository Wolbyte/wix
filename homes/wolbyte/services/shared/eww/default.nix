{
  pkgs,
  config,
  lib,
  osConfig,
  ...
}:
with lib;
with lib.wb; let
  inherit (osConfig.wb) device system;
  inherit (config.colorscheme) palette;

  acceptedTypes = ["desktop" "hybrid"];
in {
  config = mkIf (builtins.elem device.profile acceptedTypes && system.video.enable) {
    #TODO: Revamp eww bar & come up with a service based solution
    #TODO: Use the original package when a new release is dropped
    home.packages = [
      (pkgs.eww.overrideAttrs (old: let
        pname = "eww";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "elkowar";
          repo = "eww";
          rev = "1e37f53e99016aa2cd725d7050788bb5d4fcc76a";
          hash = "sha256-dm4bufwlVDUE4ndsR6cAPur75hvlVRzIxbMKJCizutg=";
        };
      in {
        inherit pname;
        inherit version;
        inherit src;

        cargoDeps = pkgs.eww.cargoDeps.overrideAttrs (oldDeps: {
          inherit src;
          name = "${pname}-${version}-vendor.tar.gz";
          outputHash = "sha256-S+oxWHDrtg2t+hqXZdBFGY7G3+YZZUAmx6//iGgeKn0=";
        });

        buildInputs = old.buildInputs ++ (with pkgs; [glib librsvg libdbusmenu-gtk3]);
      }))
    ];

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
