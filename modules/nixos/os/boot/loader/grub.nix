{ lib, config, ... }:
with lib;
let
  cfg = config.wix.system.boot;
in
{
  config = mkIf (cfg.loader == "grub") {
    boot.loader.grub = {
      inherit (cfg) device;

      enable = true;

      useOSProber = true;

      efiSupport = true;
    };
  };
}
