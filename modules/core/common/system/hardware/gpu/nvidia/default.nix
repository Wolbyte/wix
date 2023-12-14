{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  inherit (config.wb) device env;

  nvStable = config.boot.kernelPackages.nvidiaPackages.stable;
  nvBeta = config.boot.kernelPackages.nvidiaPackages.beta;
  nvPackage =
    if (versionOlder nvBeta.version nvStable.version)
    then nvStable
    else nvBeta;
in {
  config = mkIf (device.gpu == "nvidia" || device.gpu == "hybrid-nv") {
    nixpkgs.config.allowUnfree = true;

    services.xserver.videoDrivers = ["nvidia"];
    boot.blacklistedKernelModules = ["nouveau"];

    environment = {
      sessionVariables = mkMerge [
        {LIBVA_DRIVER_NAME = "nvidia";}

        (mkIf env.isWayland {
          WLR_NO_HARDWARE_CURSORS = "1";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          GBM_BACKEND = "nvidia-drm";
        })
      ];

      systemPackages = with pkgs; [
        mesa

        vulkan-tools
        vulkan-loader
        vulkan-validation-layers
        vulkan-extension-layer

        libva
        libva-utils
      ];
    };

    hardware = {
      nvidia = {
        package = mkDefault nvPackage;
        modesetting.enable = mkDefault true;
        prime.offload.enableOffloadCmd = device.gpu == "hybrid-nv";
        powerManagement = {
          enable = mkDefault true;
          finegrained = mkDefault device.gpu == "hybrid-nv";
        };

        # TODO: change to true once nvidia-open works with vaapi
        open = mkDefault false;
        nvidiaPersistenced = true;
        forceFullCompositionPipeline = true;
      };

      opengl = {
        extraPackages = with pkgs; [nvidia-vaapi-driver];
        extraPackages32 = with pkgs.pkgsi686Linux; [nvidia-vaapi-driver];
      };
    };
  };
}
