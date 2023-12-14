{pkgs, ...}: let
  codelldb = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/";
in {
  programs.nixvim = {
    plugins = {
      clangd-extensions = {
        enable = true;
        enableOffsetEncodingWorkaround = true;

        memoryUsage.border = "rounded";
        symbolInfo.border = "rounded";
      };

      dap.adapters.servers.codelldb = {
        host = "127.0.0.1";
        port = "\${port}";
        executable = {
          command = "${codelldb}/adapter/codelldb";
          args = ["--liblldb" "${codelldb}/lldb/lib/liblldb.so" "--port" "\${port}"];
        };
      };

      dap.configurations.cpp = [
        {
          name = "Launch file";
          type = "codelldb";
          request = "launch";
          program.__raw = ''
            function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end
          '';
          cwd = "\${workspaceFolder}";
          stopOnEntry = false;
        }
      ];

      lsp.servers.clangd = {
        enable = true;
        onAttach.function = ''
          require("clangd_extensions.inlay_hints").setup_autocmd()
          require("clangd_extensions.inlay_hints").set_inlay_hints()
        '';
      };

      none-ls = {
        sourcesItems = [
          {__raw = "require('null-ls').builtins.formatting.clang_format";}
          {__raw = "require('null-ls').builtins.diagnostics.clang_check";}
        ];
      };
    };
    extraPackages = with pkgs; [clang-tools];
  };
}
