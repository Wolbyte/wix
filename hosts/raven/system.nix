{
  config = {
    wix = {
      host = {
        profile = "desktop";

        cpu = {
          vendor = "intel";
          enableIGPU = false;
        };

        gpu.vendor = "nvidia";

        enableBluetooth = false;

        displayServer = "wayland";

        desktopEnvironment = "Hyprland";
      };

      system = {
        boot.silentBoot = true;
      };
    };
  };
}
