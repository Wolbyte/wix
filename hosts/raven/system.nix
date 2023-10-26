{
  config = {
    wb = {
      device = {
        profile = "desktop";
        cpu = {
          vendor = "intel";
          hasIntegratedGraphics = false;
        };
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
