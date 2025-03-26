{ config, ... }:
{
  imports = [
    ./bat.nix
    ./git.nix
  ];

  programs = {
    btop = {
      enable = true;

      settings = {
        colorscheme = "TTY";

        vim_keys = true;
      };
    };

    eza = {
      enable = true;

      icons = "auto";

      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };

    dircolors = {
      enable = true;

      enableZshIntegration = config.programs.zsh.enable;

      enableBashIntegration = true;
    };

    man.enable = true;
  };
}
