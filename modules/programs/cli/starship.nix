{
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.programs.cli.starship;
in {
  options.wb.programs.cli.starship = {
    enable = mkEnableOption "starship";
  };

  config = mkIf cfg.enable {
    hm.programs.starship = {
      enable = true;
      enableFishIntegration = config.wb.shell.fish.enable || config.programs.fish.enable;

      settings = let
        git = "$git_branch$git_commit$git_state$git_status";
      in {
        add_newline = false;

        format = "$os$directory${git}$fill$cmd_duration$time$line_break$character";

        os = {
          disabled = false;
          style = "bold fg:cyan";
          format = "[$symbol]($style) ";
        };

        directory = {
          read_only = " ";
          style = "bold accent";
          truncate_to_repo = false;
          format = "([$read_only]($read_only_style))[$path]($style) ";
        };

        time = {
          disabled = false;
          time_format = "%r";
          format = "[󰥔](fg:accent) [$time]($style)";
          use_12hr = true;
        };

        cmd_duration = {
          disabled = false;
          min_time = 2000;
          format = "[](fg:accent) [$duration]($style) ";
        };

        character = {
          success_symbol = "[➜](bold accent_alt)";
          error_symbol = "[➜](bold red)";
        };

        git_branch = {
          disabled = false;
          symbol = "  ";
          style = "fg:accent_alt";
          format = "[$symbol$branch(:$remote_branch)]($style) ";
        };

        git_commit = {
          disabled = false;
          tag_symbol = " ";
          format = "[\($hash$tag\)]($style) ";
        };

        git_status = {
          disabled = false;
          modified = "!$\{count\}";
          ahead = "⇡$\{count\}";
          behind = "⇣$\{count\}";
          staged = "+$\{count\}";
          deleted = "✘$\{count\}";
          untracked = "?$\{count\}";
        };

        fill = {
          disabled = false;
          symbol = " ";
        };

        palette = "nix";

        palettes.nix = {
          base = "#191724";
          text = "#e0def4";
          overlay = "#26233a";
          accent = "#c4a7e7";
          accent_alt = "#ebbcba";
          cyan = "#9ccfd8";

          red = "#eb6f92";
          green = "#9ccfd8";
          yellow = "#f6c177";
        };

        os.symbols = {
          Alpaquita = " ";
          Alpine = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          Artix = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          OpenBSD = "󰈺 ";
          openSUSE = " ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          Redox = "󰀘 ";
          Solus = "󰠳 ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Windows = "󰍲 ";
        };
      };
    };
  };
}
