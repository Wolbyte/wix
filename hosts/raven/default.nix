{
  pkgs,
  config,
  ...
}: {
  imports = [./hardware-configuration.nix];

  user.shell = pkgs.fish;

  boot.loader.grub = {
    extraEntries = ''
      menuentry "Windows" --class windows {
        insmod part_gpt
        insmod fat
        insmod search_fs_uuid
        insmod chain
        chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      }
    '';
  };

  # TODO: add proper support for openvpn
  environment.systemPackages = [pkgs.openvpn];

  time.timeZone = "Asia/Tehran";

  services.xserver = {
    layout = "us,ir";
    xkbOptions = "grp:win_space_toggle";

    xrandrHeads = [
      {
        output = "HDMI-0";
        primary = true;
      }
    ];
  };

  wb = {
    wallpaper = {
      normal = config.wb.wallpapers.aenami-out-of-time;
      live = config.wb.wallpapers.night-sky-purple-moon-clouds;
      preferredType = "live";
    };

    desktopEnvironments.hyprland.enable = true;

    dev = {
      rust.enable = true;
    };

    displayServers.x11.xprofile = {
      enable = true;
      config = ''
        xrandr --dpi 90
      '';
    };

    displayManagers.sddm.enable = true;

    fonts = {
      enable = true;
      extraFonts = {
        "fontawesome" = {
          family = "Font Awesome 6 Free";
          package = pkgs.font-awesome;
          type = "regular";
        };
      };
    };

    gtk.enable = true;
    qt.enable = true;

    hardware = {
      audio = {
        enable = true;
        utils = true;
      };

      nvidia = {
        enable = true;
        initrd = true;
        nvidiaOpen = true;
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
        eww.enable = true;
        rofi.enable = true;
        telegram.enable = true;
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

      system.coolercontrol = {
        enable = true;
        gui.enable = true;
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
