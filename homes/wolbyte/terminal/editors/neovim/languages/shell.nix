{
  programs.nixvim = {
    plugins = {
      lsp.servers.bashls.enable = true;

      none-ls.sources = {
        diagnostics.shellcheck.enable = true;
        formatting.shfmt.enable = true;
      };
    };
  };
}
