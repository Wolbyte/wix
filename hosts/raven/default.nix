{
  imports = [./hardware-configuration.nix];

  wb = {
    hardware = {
      nvidia = {
        enable = true;
        initrd = true;
        nvidiaOpen = true;
        waylandTweaks = true;
      };
    };
  };
}
