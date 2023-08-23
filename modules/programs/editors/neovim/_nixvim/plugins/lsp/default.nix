{
  imports = [
    ./_lsp-diagnostic-config.nix
    ./lspsaga.nix
  ];

  programs.nixvim = {
    plugins.lsp = {
      enable = true;
    };
  };
}
