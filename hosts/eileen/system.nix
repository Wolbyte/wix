{
  config = {
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
