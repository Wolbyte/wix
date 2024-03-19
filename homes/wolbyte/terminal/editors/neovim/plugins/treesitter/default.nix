{
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;

        incrementalSelection = {
          enable = true;

          keymaps = {
            initSelection = "<C-space>";
            nodeIncremental = "<C-space>";
            nodeDecremental = "<bs>";
          };
        };

        indent = true;
      };

      ts-autotag.enable = true;

      ts-context-commentstring = {
        enable = true;

        extraOptions = {
          enable_autocmd = false;
        };
      };

      treesitter-context = {
        enable = true;

        mode = "cursor";

        maxLines = 3;
      };

      treesitter-textobjects.enable = true;
    };
  };
}
