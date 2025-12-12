{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  host = config.wix.host;

  stablePackage = config.boot.kernelPackages.nvidiaPackages.stable;

  betaPackage = config.boot.kernelPackages.nvidiaPackages.beta;

  driverPackage =
    if (versionOlder betaPackage.version stablePackage.version) then stablePackage else betaPackage;

  isHybrid = host.gpu.vendor == "nvidia-hybrid";
in
{
  config = mkIf (host.gpu.vendor == "nvidia" || host.gpu.vendor == "nvidia-hybrid") {
    nixpkgs.config.allowUnfree = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    boot = {
      blacklistedKernelModules = [ "nouveau" ];

      kernelParams = [ "nvidia-drm.fbdev=1" ];
    };

    hardware = {
      nvidia = {
        package = mkDefault driverPackage;

        open = mkDefault true;

        modesetting.enable = mkDefault true;

        videoAcceleration = true;

        prime.offload = {
          enable = isHybrid;
          enableOffloadCmd = isHybrid;
        };

        powerManagement = {
          enable = mkDefault true;

          finegrained = mkDefault false;
        };
      };
    };

    environment.variables = mkMerge [
      { LIBVA_DRIVER_NAME = "nvidia"; }

      (mkIf (host.displayServer == "wayland") {
        # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        # GBM_BACKEND = "nvidia-drm";
        NVD_BACKEND = "direct";
        MOZ_DISABLE_RDD_SANDBOX = 1; # To make hardware acceleration work in firefox
      })
    ];

    environment.systemPackages = with pkgs; [
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer

      libva
      libva-utils
    ];
  };
}
