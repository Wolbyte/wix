{
  config,
  inputs,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.desktopEnvironments.hyprland;
in {
  options.wb.desktopEnvironments.hyprland = {
    enable = mkEnableOption "hyprland";
  };

  imports = [inputs.hyprland.nixosModules.default];

  config = mkIf cfg.enable {
    wb.displayServers.wayland.enable = true;

    programs.hyprland = {
      enable = true;
      nvidiaPatches = config.wb.hardware.gpu.vendor == "nvidia";
    };
  };
}
