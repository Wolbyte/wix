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
      browsers = {
        default = "firefox";
        firefox.enable = true;
      };

      cli = {
        git.enable = true;
        gnupg.enable = true;
        starship.enable = true;
      };

      desktop = {
        rofi.enable = true;
      };

      editors.neovim = {
        enable = true;
        defaultEditor = true;
      };

      media = {
        spotify.enable = true;
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
