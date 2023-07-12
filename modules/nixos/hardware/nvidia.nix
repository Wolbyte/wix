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

    waylandTweaks = defaultOpts.mkBool false "Tweaks to make nvidia better on wayland.";

    initrd = defaultOpts.mkBool false "Whether to add nvidia kernel modules to initrd.";
  };

  config = let
    moduleOpts = with cfg; {
      wb.hardware.gpu.vendor = "nvidia";

      services.xserver.videoDrivers = ["nvidia"];

      boot.initrd = mkIf initrd (let
        kernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
      in {
        availableKernelModules = kernelModules;
        inherit kernelModules;
      });

      environment.sessionVariables =
        {
          LIBVA_DRIVER_NAME = "nvidia";
        }
        // (optionalAttrs waylandTweaks {
          GBM_BACKEND = "nvidia-drm";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        });

      hardware.nvidia = {
        inherit package;
        open = nvidiaOpen;
        modesetting = mkIf waylandTweaks {enable = true;};
      };

      hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
    };
  in
    mkIf cfg.enable moduleOpts;
}
