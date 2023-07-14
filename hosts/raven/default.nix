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

      storage = {
        enable = true;
        ssd = true;
      };
    };

    programs = {
      cli = {
        git.enable = true;
      };
    };

    services = {
      ssh.enable = true;
    };
  };
}
