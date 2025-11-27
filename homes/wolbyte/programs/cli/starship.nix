{
  lib,
  config,
  ...
}:
{
  programs.starship = {
    enable = true;

    enableBashIntegration = true;

    enableZshIntegration = config.programs.zsh.enable;

    settings = {
      format = lib.concatStrings [
        "$all"
        "$time"
        "$line_break"
        "$character"
      ];

      scan_timeout = 10;

      # Modules

      character = {
        success_symbol = "[➜ ](green)";
        error_symbol = "[➜ ](red)";
      };

      cmd_duration = {
        min_time = 3000;
        format = "[ $duration]($style) ";
      };

      directory = {
        read_only = " 󰌾";
        truncate_to_repo = false;
        style = "bold yellow";
        truncation_length = 5;
      };

      git_branch = {
        symbol = "";
        format = "[$symbol$branch(:$remote_branch)]($style) ";
      };

      git_commit.tag_symbol = " ";

      git_status = {
        style = "bold purple";
        modified = "!$\{count\}";
        ahead = "⇡$\{count\}";
        behind = "⇣$\{count\}";
        staged = "+$\{count\}";
        deleted = "✘$\{count\}";
        untracked = "?$\{count\}";
      };

      golang.disabled = true;

      nix_shell = {
        symbol = " ";
        format = "[$symbol$name]($style) ";
      };

      time = {
        disabled = false;
        style = "bold blue";
        format = "[ $time]($style) ";
        use_12hr = false;
      };
    };
  };
}
