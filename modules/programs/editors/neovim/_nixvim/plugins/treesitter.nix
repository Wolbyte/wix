{
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;

        nixvimInjections = true;

        folding = true;
        indent = true;
      };

      treesitter-context.enable = true;
    };
  };
}
