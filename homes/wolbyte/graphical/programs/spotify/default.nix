{
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}:
with lib; let
  inherit (osConfig.wb) device;

  acceptedTypes = ["desktop" "hybrid"];

  spicePkgs = inputs.spicetify.packages.${pkgs.system}.default;
in {
  imports = [inputs.spicetify.homeManagerModule];

  config = mkIf (builtins.elem device.profile acceptedTypes) {
    programs.spicetify = {
      enable = true;
      injectCss = true;
      replaceColors = true;

      overwriteAssets = true;
      sidebarConfig = true;

      theme = spicePkgs.themes.Ziro;
      colorScheme = "rose-pine";

      enabledCustomApps = with spicePkgs.apps; [
        lyrics-plus
        marketplace
        new-releases
      ];

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        # genre # Broken
        fullAppDisplay
        history
        keyboardShortcut
        playlistIcons
        shuffle
      ];
    };
  };
}
