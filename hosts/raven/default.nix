{
  pkgs,
  config,
  ...
}: {
  imports = [./hardware-configuration.nix];

  user.shell = pkgs.fish;

  # TODO: add proper support for openvpn
  environment.systemPackages = [pkgs.openvpn];

  # TODO: add SDDM module
  services = {
    xserver.enable = true;
    xserver.displayManager.sddm.enable = true;
  };

  time.timeZone = "Asia/Tehran";

  wb = {
    wallpaper = {
      normal = config.wb.wallpapers.aenami-out-of-time;
      live = config.wb.wallpapers.night-sky-purple-moon-clouds;
      preferredType = "live";
    };

    desktopEnvironments.hyprland.enable = true;

    displayServers.wayland.ozoneLayer = true;

    fonts = {
      enable = true;
    };

    gtk.enable = true;
    qt.enable = true;

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

      fileBrowsers.thunar.enable = true;

      media = {
        imv.enable = true;
        mpv = {
          enable = true;
          defaultProfiles = ["gpu-hq"];
          hardwareAcceleration = true;
        };
        mpvpaper.enable = true;
        spotify.enable = true;
      };

      term.kitty.enable = true;
    };

    services = {
      polkit = {
        enable = true;
        flavor = "kde";
      };
      ssh.enable = true;
    };

    shell.fish = {
      enable = true;
      vimBindings = true;
    };
  };
}
