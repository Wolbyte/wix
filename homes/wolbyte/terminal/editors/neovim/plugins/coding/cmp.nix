{
  programs.nixvim = {
    plugins = {
      friendly-snippets.enable = true;

      luasnip = {
        enable = true;

        extraConfig = {
          keep_roots = true;
          link_roots = true;
          link_children = true;
          delete_check_events = "TextChanged";
        };
      };

      cmp = {
        enable = true;

        settings = {
          snippet.expand = ''function(args) require("luasnip").lsp_expand(args.body) end'';

          mapping = {
            "<C-k>" = "cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }";
            "<C-j>" = "cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }";
            "<C-f>" = "cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' })";
            "<C-b>" = "cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' })";
            "<C-Space>" = "cmp.mapping(cmp.mapping.complete(), { 'i', 'c' })";
            "<C-e>" = "cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() }";
            "<CR>" = "cmp.mapping.confirm { select = false }";
            "<S-CR>" = "cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }";
          };

          sources = [
            {
              name = "nvim_lsp";
              priority = 1000;
            }
            {
              name = "luasnip";
              priority = 750;
            }
            {
              name = "buffer";
              priority = 500;
            }
            {
              name = "path";
              priority = 250;
            }
            {name = "nvim-lsp-signature-help";}
          ];

          window = let
            windowOpts = {
              border = "rounded";
              winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None";
            };
          in {
            completion = windowOpts;
            documentation = windowOpts;
          };
        };
      };
    };
  };
}
