{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.programs.media.spotify;
in {
  options.wb.programs.media.spotify = {
    enable = mkEnableOption "spotify";
  };

  imports = [inputs.spicetify-nix.nixosModule];

  config = mkIf cfg.enable {
    programs.spicetify = let
      spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
    in {
      enable = true;

      theme = spicePkgs.themes.Ziro;
      colorScheme = "rose-pine";

      enabledCustomApps = with spicePkgs.apps; [
        marketplace
        new-releases
      ];

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        keyboardShortcut
        shuffle
        history
        fullAppDisplayMod
      ];
    };
  };
}
