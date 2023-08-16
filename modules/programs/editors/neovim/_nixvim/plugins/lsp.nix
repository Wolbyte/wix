let
  icons = import ../icons.nix;
  helpers = import ../helpers.nix;
in {
  programs.nixvim = {
    plugins = {
      lsp = {
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
            vritual_text = true,
            signs = { active = signs },
            update_in_insert = true,
            underline = true,
            severity_sort = true,
            float = {
              focused = false,
              style = "minimal",
              border = "rounded",
              source = "always",
              header = "",
              prefix = "",
            },
          })
        '';
      };

      lspsaga = {
        enable = true;

        ui = {
          codeAction = icons.diagnosticHint;
          border = "rounded";
        };
      };
    };

    maps = {
      normal = with helpers; {
        ca = mkCmdKeybind "Lspsaga code_action" "LSP Code Action";
        gd = mkCmdKeybind "Lspsaga goto_definition" "Goto Definition";
        gt = mkCmdKeybind "Lspsaga goto_type_definition" "Goto Type Definition";
        gp = mkCmdKeybind "Lspsaga peek_definition" "Peek Definition";
        gP = mkCmdKeybind "Lspsaga peek_type_definition" "Peek Type Definition";
        gr = mkCmdKeybind "Lspsaga rename" "LSP Rename";
        gR = mkCmdKeybind "Lspsaga rename ++project" "LSP Rename In All Files";
      };
    };
  };
}
