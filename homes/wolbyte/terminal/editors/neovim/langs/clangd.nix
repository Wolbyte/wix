{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      clangd-extensions = {
        enable = true;

        ast = {
          roleIcons = {
            type = "";
            declaration = "";
            expression = "";
            specifier = "";
            statement = "";
            templateArgument = "";
          };

          kindIcons = {
            compound = "";
            recovery = "";
            translationUnit = "";
            packExpansion = "";
            templateTypeParm = "";
            templateTemplateParm = "";
            templateParamObject = "";
          };
        };

        enableOffsetEncodingWorkaround = true;

        inlayHints.inline = "false";

        memoryUsage.border = "rounded";

        symbolInfo.border = "rounded";
      };

      cmp.settings.sorting.comparators = ["require('clangd_extensions.cmp_scores')"];

      conform-nvim.formattersByFt = rec {
        c = ["clang_format"];
        cpp = c;
      };

      dap = {
        adapters.servers.codelldb = let
          codelldb = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/";
        in {
          host = "127.0.0.1";
          port = "\${port}";
          executable = {
            command = "${codelldb}/adapter/codelldb";
            args = ["--liblldb" "${codelldb}/lldb/lib/liblldb.so" "--port" "\${port}"];
          };
        };

        configurations = rec {
          cpp = [
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

          c = cpp;
        };
      };

      lint.lintersByFt = rec {
        c = ["clangtidy"];
        cpp = c;
      };

      lsp.servers.clangd = {
        enable = true;

        cmd = [
          "clangd"
          "--background-index"
          "--clang-tidy"
          "--header-insertion=iwyu"
          "--completion-style=detailed"
          "--function-arg-placeholders"
          "--fallback-style=llvm"
        ];

        rootDir = ''
          function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja"
          )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
            fname
          ) or require("lspconfig.util").find_git_ancestor(fname)
          end
        '';

        onAttach.function = ''
          vim.keymap.set("n", "<leader>lR", "<cmd>ClangdSwitchSourceHeader<cr>", {desc = "Switch source/header (C/C++)", buffer=bufnr})

          require("clangd_extensions.inlay_hints").setup_autocmd()
          require("clangd_extensions.inlay_hints").set_inlay_hints()
        '';
      };
    };

    extraPackages = with pkgs; [clang-tools];
  };
}
