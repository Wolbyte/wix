{lib, ...}: let
  helpers = import ./helpers.nix {inherit lib;};
in {
  programs.nixvim = {
    globals.mapleader = " ";

    keymaps = with helpers; (mkKeymaps {
      n = {
        "<C-h>" = mkLuaMap "require('smart-splits').move_cursor_left" "Move to left split";
        "<C-j>" = mkLuaMap "require('smart-splits').move_cursor_down" "Move to below split";
        "<C-k>" = mkLuaMap "require('smart-splits').move_cursor_up" "Move to above split";
        "<C-l>" = mkLuaMap "require('smart-splits').move_cursor_right" "Move to right split";
        "<C-Up>" = mkLuaMap "require('smart-splits').resize_up" "Resize split up";
        "<C-Down>" = mkLuaMap "require('smart-splits').resize_down" "Resize split down";
        "<C-Left>" = mkLuaMap "require('smart-splits').resize_left" "Resize split left";
        "<C-Right>" = mkLuaMap "require('smart-splits').resize_right" "Resize split right";

        "<leader>w" = mkCmdMap "w" "Save";
        "<leader>q" = mkCmdMap "q" "Quit";
        "<C-s>" = mkCmdMap "w!" "Force write";
        "<C-q>" = mkCmdMap "q!" "Force quit";
        "|" = mkCmdMap "vsplit" "Vertical Split";
        "\\" = mkCmdMap "split" "Horizontal Split";

        "<leader>c" = mkLuaMap "function() require('mini.bufremove').delete(0, false) end" "Close Buffer";
        "<leader>C" = mkLuaMap "function() require('mini.bufremove').delete(0, true) end" "Close Buffer (Force)";
      };

      v = {
        "<Tab>" = mkRawMap ">gv" "Indent selected lines";
        "<S-Tab>" = mkRawMap "<gv" "Unindent selected lines";

        "K" = mkRawMap ":m '<-2<CR>gv=gv" "Move selected lines up";
        "J" = mkRawMap ":m '>+1<CR>gv=gv" "Move selected lines down";
      };
    });
  };
}
