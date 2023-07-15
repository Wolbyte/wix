{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      nix.enable = true;

      lsp.servers.nil_ls.enable = true;
      null-ls.sources = {
        code_actions.statix.enable = true;
        diagnostics.statix.enable = true;
        formatting.alejandra.enable = true;
      };
    };
  };
}
