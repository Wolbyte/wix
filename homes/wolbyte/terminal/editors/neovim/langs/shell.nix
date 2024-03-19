{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      conform-nvim.formattersByFt.sh = ["shfmt"];

      lint.lintersByFt.sh = ["shellcheck"];

      lsp.servers.bashls.enable = true;
    };

    extraPackages = with pkgs; [shellcheck shfmt];
  };
}
