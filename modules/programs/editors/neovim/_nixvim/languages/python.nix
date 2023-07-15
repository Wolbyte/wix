{
  programs.nixvim = {
    plugins = {
      lsp.servers.pyright.enable = true;

      null-ls.sources = {
        diagnostics.flake8.enable = true;
        formatting.black.enable = true;
      };
    };
  };
}
