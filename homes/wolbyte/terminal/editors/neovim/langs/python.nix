{pkgs, ...}: let
  nvimPython = pkgs.python311.withPackages (ps: [
    ps.debugpy
    ps.flake8
  ]);
in {
  programs.nixvim = {
    plugins = {
      lsp.servers.pyright.enable = true;

      conform-nvim.formattersByFt.python = ["black" "isort"];

      lint.lintersByFt.python = ["flake8"];

      dap = {
        extensions.dap-python = {
          enable = true;
          adapterPythonPath = "${nvimPython}/bin/python3";
          includeConfigs = true;
        };
      };
    };

    extraPackages = with pkgs; [black isort nvimPython];
  };
}
