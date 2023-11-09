{pkgs, ...}: let
  nvimPython = pkgs.python310.withPackages (ps: [
    ps.debugpy
  ]);
in {
  programs.nixvim = {
    plugins = {
      lsp.servers.pyright.enable = true;

      none-ls.sources = {
        diagnostics.flake8.enable = true;
        formatting.black.enable = true;
      };

      dap = {
        extensions.dap-python = {
          enable = true;
          adapterPythonPath = "${nvimPython}/bin/python3.10";
          includeConfigs = true;
        };
      };
    };
  };
}
