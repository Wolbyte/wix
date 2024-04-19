{config, ...}: {
  home.sessionVariables = {
    STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
  };

  programs.starship = {
    enable = true;

    enableBashIntegration = false;

    settings = let
      git = "$git_branch$git_commit$git_state$git_metrics$git_status";
      inherit (import ./elements.nix) elements;
      elemsConcatted = builtins.concatStringsSep "" elements;
    in {
      add_newline = false;

      format = "$hostname$username$directory${git}$nix_shell${elemsConcatted}$line_break$character";

      palette = "custom";
      palettes.custom = import ./palette.nix {inherit config;};

      character = {
        success_symbol = "[](bold green)";
        error_symbol = "[](bold red)";
        vicmd_symbol = "[](bold yellow)";
        format = "$symbol [|](bold bright-black) ";
      };

      line_break.disabled = false;

      fill = {
        disabled = false;
        symbol = " ";
      };

      directory = {
        read_only = " ";
        truncate_to_repo = false;
        style = "bold yellow";
        format = "([$read_only]($read_only_style))[](bold purple)  [$path]($style) ";
      };

      time = {
        disabled = false;
        time_format = "%r";
        format = "󰥔 [$time]($style)";
        use_12hr = true;
      };

      cmd_duration = {
        disabled = false;
        min_time = 2000;
        format = " [$duration]($style) ";
      };

      git_commit.commit_hash_length = 7;

      git_branch = {
        disabled = false;
        symbol = " ";
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

      hostname = {
        format = "@[$hostname](bold blue) "; # the whitespace at the end is actually important
        ssh_only = true;
        disabled = false;
      };

      lua.symbol = "[](blue) ";
      python.symbol = "[](blue) ";
      nix_shell.symbol = "[](blue) ";
      rust.symbol = "[](red) ";
      package.symbol = "📦  ";
    };
  };
}
