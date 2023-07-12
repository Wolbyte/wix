{
  imports = [./hardware-configuration.nix];

  wb = {
    hardware = {
      audio.enable = true;

      nvidia = {
        enable = true;
        initrd = true;
        nvidiaOpen = true;
        waylandTweaks = true;
      };
    };
  };
}
