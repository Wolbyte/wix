{
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;

        folding = true;
        indent = true;
      };

      treesitter-context.enable = true;
    };
  };
}
