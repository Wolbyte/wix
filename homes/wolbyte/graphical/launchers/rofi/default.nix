{
  pkgs,
  config,
  lib,
  osConfig,
  ...
}:
with lib; let
  inherit (osConfig.wb) device env system;

  acceptedTypes = ["desktop" "hybrid"];

  rofiPackage =
    if env.isWayland
    then pkgs.rofi-wayland
    else pkgs.rofi;
in {
  config = mkIf (builtins.elem device.profile acceptedTypes && system.video.enable) {
    programs.rofi = {
      enable = true;
      package = rofiPackage;

      # TODO: uncomment once a new rofi version is released
      # plugins = with pkgs; [
      # rofi-calc
      # rofi-emoji
      # rofi-rbw
      # ];

      font = "Iosevka Nerd Font 14";

      extraConfig = import ./config.nix {};

      theme = import ./theme.nix {
        colors = config.colorscheme.palette;
        inherit (config.lib.formats.rasi) mkLiteral;
      };
    };
  };
}
