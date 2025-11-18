{
  pkgs,
  lib,
  inputs,
  osConfig,
  ...
}:
with lib;
let
  inherit (osConfig.wix) host;

  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.spicetify ];

  config = mkIf host.enableDesktopFeatures {
    programs.spicetify = {
      enable = true;

      theme = spicePkgs.themes.ziro;
      colorScheme = "rose-pine";

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        keyboardShortcut
      ];
    };
  };
}
