{
  imports = [./desktop.nix];

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

      programs = {
        cli.enable = true;
        gui.enable = true;

        git.signingKey = "0AFE0739FF35365A17725F3441332534F8740D00";
      };

      system = {
        boot = {
          loader = "grub";
          silentBoot = true;
        };

        audio.enable = true;
        video.enable = true;
      };
    };
  };
}
