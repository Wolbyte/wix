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
