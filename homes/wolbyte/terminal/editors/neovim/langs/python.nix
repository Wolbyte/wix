{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      lsp.servers.pyright.enable = true;

      conform-nvim.formattersByFt.python = ["black" "isort"];

      lint.lintersByFt.python = ["flake8"];

      dap = {
        extensions.dap-python = {
          enable = true;
          includeConfigs = true;
        };
      };
    };

    extraPackages = with pkgs; [
      black
      isort
      python311Packages.flake8
    ];
  };
}
