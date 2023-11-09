{pkgs, ...}: let
  windowOpts = {
    border = "rounded";
    winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None";
  };
in {
  programs.nixvim = {
    options.completeopt = ["menu" "menuone" "noselect"];

    extraPlugins = with pkgs.vimPlugins; [
      friendly-snippets
    ];

    plugins = {
      luasnip = {
        enable = true;
        fromVscode = [{}];
      };

      lspkind = {
        enable = true;

        mode = "symbol";

        symbolMap = {
          Array = "󰅪";
          Boolean = "⊨";
          Class = "󰌗";
          Constructor = "";
          Key = "󰌆";
          Namespace = "󰅪";
          Null = "NULL";
          Number = "#";
          Object = "󰀚";
          Package = "󰏗";
          Property = "";
          Reference = "";
          Snippet = "";
          String = "󰀬";
          TypeParameter = "󰊄";
          Unit = "";
        };

        cmp = {
          enable = true;

          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[API]";
            path = "[PATH]";
            luasnip = "[SNIP]";
            buffer = "[BUFFER]";
          };
        };
      };

      nvim-cmp = {
        enable = true;
        preselect = "None";
        snippet.expand = "luasnip";

        mapping = {
          "<Up>" = "cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }";
          "<Down>" = "cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }";
          "<C-p>" = "cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }";
          "<C-n>" = "cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }";
          "<C-k>" = "cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }";
          "<C-j>" = "cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }";
          "<C-u>" = "cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' })";
          "<C-d>" = "cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' })";
          "<C-Space>" = "cmp.mapping(cmp.mapping.complete(), { 'i', 'c' })";
          "<C-y>" = "cmp.config.disable";
          "<C-e>" = "cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() }";
          "<CR>" = "cmp.mapping.confirm { select = false }";
          "<Tab>" = ''
            cmp.mapping(function(fallback)
              local function has_words_before()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
              end

              local luasnip = require("luasnip")

              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end, { "i", "s" })
          '';
          "<S-Tab>" = ''
            cmp.mapping(function(fallback)
              local luasnip = require("luasnip")

              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" })
          '';
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
        ];

        window = {
          completion = windowOpts;
          documentation = windowOpts;
        };
      };
    };
  };
}
