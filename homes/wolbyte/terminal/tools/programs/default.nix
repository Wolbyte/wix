{
  imports = [
    ./bat
    ./git
  ];

  programs = {
    btop = {
      enable = true;
      settings = {
        color_theme = "TTY";
        vim_keys = true;
      };
    };

    dircolors = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        OTHER_WRITABLE = "30;46";
        ".sh" = "01;32";
        ".csh" = "01;32";
      };
    };

    eza = {
      enable = true;
      icons = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };

    man.enable = true;
  };
}
