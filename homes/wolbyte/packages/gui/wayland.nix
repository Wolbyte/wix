{
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib; let
  inherit (osConfig.wb) env programs system;
in {
  config = mkIf (system.video.enable && programs.gui.enable && env.isWayland) {
    home.packages = with pkgs; [
      swappy
      wlogout
    ];
  };
}
