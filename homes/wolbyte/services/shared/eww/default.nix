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
    #TODO: Switch to the original package once the systray pr is merged
    home.packages = [
      (pkgs.eww.overrideAttrs (old: let
        pname = "eww";
        version = "tray-v3";
        src = pkgs.fetchFromGitHub {
          owner = "ralismark";
          repo = "eww";
          rev = "6f5cdd37885593839e6ffd9268ccd1e23e45115d";
          hash = "sha256-dO6FzSwtoGSy38HojBk1rVL6Hs6GqmdXnDvVLzB32gs=";
        };
        patches = [./6_mouseHandling.patch];
      in {
        inherit pname;
        inherit version;
        inherit src;

        inherit patches;

        cargoDeps = pkgs.eww.cargoDeps.overrideAttrs (oldDeps: {
          inherit src;
          inherit patches;
          name = "${pname}-${version}-vendor.tar.gz";
          outputHash = "sha256-z8atgiEgYHHNQW9m6tsOflj4GvJGs/g/aEgv0yHD3O0=";
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
