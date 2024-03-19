let
  helpers = import ../../helpers.nix;
in
  with helpers; {
    programs.nixvim = {
      plugins.noice = {
        enable = true;

        lsp.override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };

        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          inc_rename = true;
        };

        routes = [
          {
            filter = {
              event = "msg_show";
              any = [
                {find = "%d+L, %d+B";}
                {find = "; after #%d+";}
                {find = "; before #%d+";}
              ];
            };
            view = "mini";
          }
        ];
      };

      keymaps = [
        (mkLuaKeymap "<S-Enter>" ["c"] "function() require('noice').redirect(vim.fn.getcmdline()) end" {desc = "Redirect cmdline";})
        (mkLuaKeymap "<leader>snl" ["n"] "function() require('noice').cmd('last') end" {desc = "Noice last message";})
        (mkLuaKeymap "<leader>snh" ["n"] "function() require('noice').cmd('history') end" {desc = "Noice history";})
        (mkLuaKeymap "<leader>sna" ["n"] "function() require('noice').cmd('all') end" {desc = "Noice all";})
        (mkLuaKeymap "<leader>snd" ["n"] "function() require('noice').cmd('dismiss') end" {desc = "Dismiss all";})
        (mkLuaKeymap "<c-f>" ["i" "n" "s"] "function() if not require('noice.lsp').scroll(4) then return '<c-f>' end end" {
          desc = "Scroll forward";
          silent = true;
          expr = true;
        })
        (mkLuaKeymap "<c-b>" ["i" "n" "s"] "function() if not require('noice.lsp').scroll(-4) then return '<c-b>' end end" {
          desc = "Scroll backward";
          silent = true;
          expr = true;
        })
      ];
    };
  }
