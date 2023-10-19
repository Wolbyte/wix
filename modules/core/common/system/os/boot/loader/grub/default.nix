{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.wb.system.boot;
in {
  config = mkIf (cfg.loader == "grub") {
    boot.loader.grub = {
      enable = mkDefault true;
      useOSProber = true;
      efiSupport = true;
      inherit (cfg) device;
    };
  };
}
