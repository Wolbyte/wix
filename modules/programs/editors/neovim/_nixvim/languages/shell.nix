{
  programs.nixvim = {
    plugins = {
      lsp.servers.bashls.enable = true;

      null-ls.sources = {
        diagnostics.shellcheck.enable = true;
        formatting.shfmt.enable = true;
      };
    };
  };
}
