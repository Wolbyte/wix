{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      conform-nvim.formattersByFt = let
        eslint_prettier = ["eslint_d" "prettierd"];
      in {
        html = eslint_prettier;
        css = eslint_prettier;
        javascript = eslint_prettier;
      };

      lint.lintersByFt = {
        html = ["htmlhint"];
        javascript = ["eslint_d"];
      };

      lsp.servers = {
        html.enable = true;
        cssls.enable = true;
        jsonls.enable = true;
        eslint.enable = true;
      };
    };

    extraPackages = with pkgs; [
      eslint_d
      htmlhint
      prettierd
    ];
  };
}
