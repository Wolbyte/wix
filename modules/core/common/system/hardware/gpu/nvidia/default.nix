{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  inherit (config.wb) device env;

  stableDriver = config.boot.kernelPackages.nvidiaPackages.stable;

  betaDriver = config.boot.kernelPackages.nvidiaPackages.beta;

  driverPackage =
    if (versionOlder betaDriver.version stableDriver.version)
    then stableDriver
    else betaDriver;
in {
  config = mkIf (device.gpu == "nvidia" || device.gpu == "hybrid-nv") {
    nixpkgs.config.allowUnfree = true;

    services.xserver.videoDrivers = ["nvidia"];

    boot.blacklistedKernelModules = ["nouveau"];

    boot.kernelParams = ["nvidia-drm.fbdev=1"];

    hardware = {
      nvidia = {
        package = mkDefault driverPackage;

        modesetting.enable = mkDefault true;

        prime.offload.enableOffloadCmd = device.gpu == "hybrid-nv";

        powerManagement = {
          enable = mkDefault true;

          finegrained = mkDefault device.gpu == "hybrid-nv";
        };

        open = mkDefault true;

        nvidiaPersistenced = true;

        forceFullCompositionPipeline = true;
      };

      opengl = {
        extraPackages = with pkgs; [nvidia-vaapi-driver];

        extraPackages32 = with pkgs.pkgsi686Linux; [nvidia-vaapi-driver];
      };
    };

    environment = {
      sessionVariables = mkMerge [
        {LIBVA_DRIVER_NAME = "nvidia";}

        (mkIf env.isWayland {
          NVD_BACKEND = "direct";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          GBM_BACKEND = "nvidia-drm";
          # Prevent mesa ICDs from being loaded
          VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
        })

        (mkIf (env.desktopEnv != "Hyprland") {
          # Hardware cursor is fixed in wlroots-hyprland
          WLR_NO_HARDWARE_CURSORS = "1";
        })
      ];

      systemPackages = with pkgs;
        mkMerge [
          [
            # Mesa
            mesa

            # Vulkan
            vulkan-tools
            vulkan-loader
            vulkan-validation-layers
            vulkan-extension-layer

            # VA-API
            libva
            libva-utils
          ]

          (mkIf env.isWayland [xwayland])
        ];
    };
  };
}
