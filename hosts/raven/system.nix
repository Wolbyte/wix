{
  config = {
    wb = {
      device = {
        profile = "desktop";
        cpu = {
          vendor = "intel";
          hasIntegratedGraphics = false;
        };
        gpu = "nvidia";
        hasBluetooth = false;
        hasSound = true;
        hasTPM = true;
      };

      system = {
        boot = {
          loader = "grub";
          silentBoot = true;
        };
      };
    };
  };
}
