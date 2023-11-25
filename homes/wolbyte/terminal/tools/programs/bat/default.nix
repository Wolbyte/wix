{pkgs, ...}: {
  programs.bat = {
    enable = true;

    themes = {
      rose-pine = {
        src = pkgs.fetchFromGitHub {
          owner = "rose-pine";
          repo = "sublime-text";
          rev = "79dfbdac3bf42788e4ba6cf5ad8564aa13f2f7d5";
          hash = "sha256-zQ/H7W6ToRy6J0vVtHDqV6rbyUdG1EpGb07HsV+2R24=";
        };
        file = "rose-pine.tmTheme";
      };
    };

    config = {
      theme = "rose-pine";
      pager = "less -FR";
    };
  };
}
