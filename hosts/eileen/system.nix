{
  config = {
    hardware = {
      nvidia = {
        prime = {
          amdgpuBusId = "PCI:5:0:0";

          nvidiaBusId = "PCI:1:0:0";
        };
      };
    };

    wix = {
      host = {
        profile = "desktop";

        cpu = {
          vendor = "amd";
          enableIGPU = true;
        };

        gpu.vendor = "nvidia-hybrid";

        bluetooth.enable = true;

        displayServer = "wayland";

        desktopEnvironment = "Hyprland";
      };

      system = {
        boot.silentBoot = true;
      };
    };
  };
}
