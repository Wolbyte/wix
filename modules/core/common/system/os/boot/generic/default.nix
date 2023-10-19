{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.wb.system.boot;
in {
  config = {
    boot = {
      consoleLogLevel = 0;

      kernelPackages = cfg.kernel;

      loader = {
        timeout = 2;

        generationsDir.copyKernels = true;

        efi.canTouchEfiVariables = true;
      };

      kernelParams = mkMerge [
        (mkIf cfg.silentBoot ["quiet"])
      ];
    };
  };
}
