{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      conform-nvim.formattersByFt.nix = ["alejandra"];

      lint.lintersByFt.nix = ["statix"];

      lsp.servers.nil_ls.enable = true;

      nix.enable = true;

      treesitter.nixvimInjections = true;
    };

    extraPackages = with pkgs; [alejandra statix];
  };
}
