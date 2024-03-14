{
  programs.nixvim = {
    plugins = {
      lsp.servers = {
        html.enable = true;
        cssls.enable = true;
        jsonls.enable = true;
        eslint.enable = true;
      };

      none-ls.sources = {
        # diagnostics.eslint_d.enable = true;
        formatting = {
          # eslint_d.enable = true;
          prettierd.enable = true;
        };
      };
    };
  };
}
