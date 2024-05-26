{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      conform-nvim.formattersByFt = let
        prettierd = ["prettierd"];
      in {
        html = prettierd;
        css = prettierd;
        javascript = prettierd;
        javascriptreact = prettierd;
        typescript = prettierd;
        typescriptreact = prettierd;
      };

      lint.lintersByFt = {
        html = ["htmlhint"];
        javascript = ["eslint_d"];
        javascriptreact = ["eslint_d"];
        typescript = ["eslint"];
        typescriptreact = ["eslint"];
      };

      lsp.servers = {
        cssls.enable = true;
        emmet_ls.enable = true;
        html.enable = true;
        jsonls.enable = true;
        tsserver.enable = true;
      };
    };

    extraPackages = with pkgs; [
      eslint_d
      htmlhint
      prettierd
    ];
  };
}
