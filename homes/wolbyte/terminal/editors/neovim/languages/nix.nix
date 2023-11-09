{
  programs.nixvim = {
    plugins = {
      nix.enable = true;

      lsp.servers.nil_ls.enable = true;

      none-ls.sources = {
        diagnostics.statix.enable = true;
        formatting.alejandra.enable = true;
      };
    };
  };
}
