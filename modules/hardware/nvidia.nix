{
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.hardware.nvidia;
in {
  options.wb.hardware.nvidia = {
    enable = mkEnableOption "Nvidia";

    package = mkPackageOpt "Nvidia driver" config.boot.kernelPackages.nvidiaPackages.stable;

    nvidiaOpen = defaultOpts.mkBool false "Whether to use nvidia open kernel modules.";

    waylandTweaks = defaultOpts.mkBool (config.wb.displayServer == "wayland") "Tweaks to make nvidia better on wayland.";

    forceFullCompositionPipeline = defaultOpts.mkBool (config.wb.displayServer == "x11") "Whether to enable forceFullCompositionPipeline.";

    initrd = defaultOpts.mkBool false "Whether to add nvidia kernel modules to initrd.";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      wb.hardware.gpu.vendor = "nvidia";

      environment.sessionVariables = {
        LIBVA_DRIVER_NAME = "nvidia";
      };

      services.xserver.videoDrivers = ["nvidia"];

      hardware.nvidia = {
        inherit (cfg) package;
        open = cfg.nvidiaOpen;
        inherit (cfg) forceFullCompositionPipeline;
      };

      hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
    }

    (mkIf cfg.initrd {
      boot.initrd = rec {
        availableKernelModules = ["nvidia" "nvidia_uvm" "nvidia_drm"];
        kernelModules = availableKernelModules;
      };
    })

    (mkIf cfg.waylandTweaks (mkMerge [
      {
        environment.sessionVariables = {
          GBM_BACKEND = "nvidia-drm";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          WLR_NO_HARDWARE_CURSORS = "1";
        };

        hardware.nvidia.modesetting.enable = true;
      }
      (mkIf cfg.initrd {
        boot.initrd = {
          availableKernelModules = ["nvidia_modeset"];
          kernelModules = ["nvidia_modeset"];
        };
      })
    ]))
  ]);
}
