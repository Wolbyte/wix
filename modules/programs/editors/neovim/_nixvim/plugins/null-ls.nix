{
  programs.nixvim = {
    plugins.null-ls = {
      enable = true;
      updateInInsert = true;

      onAttach = ''
        function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                if vim.g.format_on_save then
                  vim.lsp.buf.format({ bufnr = bufnr })
                end
              end,
            })
          end
        end
      '';
    };
  };
}
