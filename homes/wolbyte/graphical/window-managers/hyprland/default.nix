{
  inputs',
  lib,
  osConfig,
  ...
}:
with lib; let
  inherit (osConfig.wb) env;
  sys = osConfig.wb.system;
in {
  imports = [./config.nix];

  config = mkIf (sys.video.enable && env.isWayland && env.desktopEnv == "Hyprland") {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs'.hyprland.packages.default;

      xwayland.enable = true;

      systemd = {
        enable = true;
        variables = ["--all"];
      };
    };
  };
}
