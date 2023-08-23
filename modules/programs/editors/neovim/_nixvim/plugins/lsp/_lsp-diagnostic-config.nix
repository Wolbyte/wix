let
  icons = import ../../icons.nix;
in {
  programs.nixvim = {
    plugins.lsp.preConfig = ''
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
}
