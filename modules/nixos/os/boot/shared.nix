{ lib, config, ... }:
with lib;
let
  cfg = config.wix.system.boot;
in
{
  config = {
    boot = {
      consoleLogLevel = 0;

      inherit (cfg) kernelPackages;

      loader = {
        timeout = mkDefault 5;

        generationsDir.copyKernels = true;

        efi.canTouchEfiVariables = true;
      };

      kernelParams = mkMerge [
        (mkIf cfg.silentBoot [ "quiet" ])
      ];
    };
  };
}
