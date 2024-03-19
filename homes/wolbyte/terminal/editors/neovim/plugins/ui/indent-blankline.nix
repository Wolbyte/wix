{
  programs.nixvim = {
    plugins.indent-blankline = {
      enable = true;

      indent.char = "│";

      scope.enabled = false;

      exclude = {
        buftypes = [
          "nofile"
          "terminal"
        ];

        filetypes = [
          "help"
          "startify"
          "aerial"
          "alpha"
          "dashboard"
          "lazy"
          "neogitstatus"
          "NvimTree"
          "neo-tree"
          "Trouble"
          "trouble"
          "mason"
          "notify"
          "toggleterm"
          "lazyterm"
        ];
      };
    };
  };
}
