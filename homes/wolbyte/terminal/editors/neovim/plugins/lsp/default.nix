let
  icons = import ../../icons.nix;
in {
  imports = [./lspsaga.nix];

  programs.nixvim = {
    plugins.lsp = {
      enable = true;

      preConfig = ''
        local signs = {
          { name = "DiagnosticSignError", text = "${icons.diagnosticError}", texthl = "DiagnosticSignError" },
          { name = "DiagnosticSignWarn", text = "${icons.diagnosticWarn}", texthl = "DiagnosticSignWarn" },
          { name = "DiagnosticSignHint", text = "${icons.diagnosticHint}", texthl = "DiagnosticSignHint" },
          { name = "DiagnosticSignInfo", text = "${icons.diagnosticInfo}", texthl = "DiagnosticSignInfo" },
        }

        for _, sign in ipairs(signs) do
          vim.fn.sign_define(sign.name, sign)
        end

        vim.diagnostic.config({
          underline = true,
          update_in_insert = true,
          severity_sort = true,
          vritual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
          },
          signs = { active = signs },
          float = {
            focused = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
          },
        })

        function __lsp_on_rename(from, to)
          local clients = vim.lsp.buf_get_clients()

          for _, client in ipairs(clients) do
            if client.supports_method("workspace/willRenameFiles") then
              local resp = client.request_sync("workspace/willRenameFiles", {
                files = {
                  {
                    oldUri = vim.uri_from_fname(from),
                    newUri = vim.uri_from_fname(to),
                  },
              }, }, 1000, 0)
              if resp and resp.result ~= nil then
                vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
              end
            end
          end
        end
      '';
    };
  };
}
