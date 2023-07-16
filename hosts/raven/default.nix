{pkgs, ...}: {
  imports = [./hardware-configuration.nix];

  user.shell = pkgs.fish;

  # TODO: add proper support for openvpn
  environment.systemPackages = [pkgs.openvpn];

  time.timeZone = "Asia/Tehran";

  wb = {
    desktopEnvironments.hyprland.enable = true;

    displayServers.wayland.ozoneLayer = true;

    fonts = {
      enable = true;
    };

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
        starship.enable = true;
      };

      editors.neovim = {
        enable = true;
        defaultEditor = true;
      };

      term.kitty.enable = true;
    };

    services = {
      ssh.enable = true;
    };

    shell.fish = {
      enable = true;
      vimBindings = true;
    };
  };
}
