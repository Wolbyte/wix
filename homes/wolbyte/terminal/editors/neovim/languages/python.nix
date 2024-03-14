{pkgs, ...}: let
  nvimPython = pkgs.python311.withPackages (ps: [
    ps.debugpy
  ]);
in {
  programs.nixvim = {
    plugins = {
      lsp.servers.pyright.enable = true;

      none-ls.sources = {
        # diagnostics.flake8.enable = true;
        formatting.black.enable = true;
      };

      dap = {
        extensions.dap-python = {
          enable = true;
          adapterPythonPath = "${nvimPython}/bin/python3";
          includeConfigs = true;
        };
      };
    };
  };
}
