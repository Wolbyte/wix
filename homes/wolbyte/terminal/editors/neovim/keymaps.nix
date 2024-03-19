let
  helpers = import ./helpers.nix;
in
  with helpers; {
    programs.nixvim = {
      globals.mapleader = " ";

      keymaps = [
        # Better up/down
        (mkRawKeymap "j" ["n" "x"] "v:count == 0 ? 'gj' : 'j'" {
          silent = true;
          expr = true;
        })
        (mkRawKeymap "k" ["n" "x"] "v:count == 0 ? 'gk' : 'k'" {
          silent = true;
          expr = true;
        })
        (mkRawKeymap "<Up>" ["n" "x"] "v:count == 0 ? 'gk' : 'k'" {
          silent = true;
          expr = true;
        })
        (mkRawKeymap "<Down>" ["n" "x"] "v:count == 0 ? 'gk' : 'k'" {
          silent = true;
          expr = true;
        })

        # Move to windows
        (mkLuaKeymap "<C-h>" ["n" "t"] "require('smart-splits').move_cursor_left" {desc = "Go to left window";})
        (mkLuaKeymap "<C-j>" ["n" "t"] "require('smart-splits').move_cursor_down" {desc = "Go to lower window";})
        (mkLuaKeymap "<C-k>" ["n" "t"] "require('smart-splits').move_cursor_up" {desc = "Go to upper window";})
        (mkLuaKeymap "<C-l>" ["n" "t"] "require('smart-splits').move_cursor_right" {desc = "Go to right window";})

        # Resize windows
        (mkLuaKeymap "<C-up>" ["n" "t"] "require('smart-splits').resize_up" {desc = "Increase window height";})
        (mkLuaKeymap "<C-down>" ["n" "t"] "require('smart-splits').resize_down" {desc = "Decrease window height";})
        (mkLuaKeymap "<C-left>" ["n" "t"] "require('smart-splits').resize_left" {desc = "Decrease window width";})
        (mkLuaKeymap "<C-right>" ["n" "t"] "require('smart-splits').resize_right" {desc = "Increase window width";})

        # Move Lines
        (mkRawKeymap "<A-j>" ["n"] "<cmd>m .+1<cr>==" {desc = "Move down";})
        (mkRawKeymap "<A-k>" ["n"] "<cmd>m .-2<cr>==" {desc = "Move up";})
        (mkRawKeymap "<A-j>" ["i"] "<esc><cmd>m .+1<cr>==gi" {desc = "Move down";})
        (mkRawKeymap "<A-k>" ["i"] "<esc><cmd>m .-2<cr>==gi" {desc = "Move up";})
        (mkRawKeymap "<A-j>" ["v"] ":m '>+1<cr>gv=gv" {desc = "Move down";})
        (mkRawKeymap "<A-k>" ["v"] ":m '<-2<cr>gv=gv" {desc = "Move up";})

        # Indent in visual mode
        (mkRawKeymap "<Tab>" ["v"] ">gv" {desc = "Indent selected lines";})
        (mkRawKeymap "<S-Tab>" ["v"] "<gv" {desc = "Unindent selected lines";})

        # Save/Quit
        (mkCmdKeymap "<leader>w" ["n"] "w" {desc = "Save file";})
        (mkCmdKeymap "<leader>q" ["n"] "q" {desc = "Quit";})

        # Splits
        (mkCmdKeymap "<leader>\\" ["n"] "split" {desc = "Horizontal split";})
        (mkCmdKeymap "<leader>|" ["n"] "vsplit" {desc = "Vertical split";})

        (
          mkLuaKeymap "<tab>" ["i"]
          "function() return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>' end"
          {
            expr = true;
            silent = true;
          }
        )
      ];
    };
  }
