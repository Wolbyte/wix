{ lib, config, ... }:
with lib;
let
  cfg = config.wix.system.boot;
in
{
  config = {
    boot = {
      consoleLogLevel = 0;

      kernelPackages = cfg.kernelPackages;

      loader = {
        timeout = 3;

        generationsDir.copyKernels = true;

        efi.canTouchEfiVariables = true;
      };

      kernelParams = mkMerge [
        (mkIf cfg.silentBoot [ "quiet" ])
      ];
    };
  };
}
