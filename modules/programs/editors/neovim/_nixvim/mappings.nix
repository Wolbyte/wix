let
  helpers = import ./helpers.nix;
in {
  programs.nixvim = {
    globals.mapleader = " ";

    maps = {
      normal = with helpers; {
        "<C-h>" = mkLuaKeybind "require('smart-splits').move_cursor_left" "Move to left split";
        "<C-j>" = mkLuaKeybind "require('smart-splits').move_cursor_down" "Move to below split";
        "<C-k>" = mkLuaKeybind "require('smart-splits').move_cursor_up" "Move to above split";
        "<C-l>" = mkLuaKeybind "require('smart-splits').move_cursor_right" "Move to right split";
        "<C-Up>" = mkLuaKeybind "require('smart-splits').resize_up" "Resize split up";
        "<C-Down>" = mkLuaKeybind "require('smart-splits').resize_down" "Resize split down";
        "<C-Left>" = mkLuaKeybind "require('smart-splits').resize_left" "Resize split left";
        "<C-Right>" = mkLuaKeybind "require('smart-splits').resize_right" "Resize split right";

        "<leader>w" = mkCmdKeybind "w" "Save";
        "<leader>q" = mkCmdKeybind "q" "Quit";
        "<C-s>" = mkCmdKeybind "w!" "Force write";
        "<C-q>" = mkCmdKeybind "q!" "Force quit";
        "|" = mkCmdKeybind "vsplit" "Vertical Split";
        "\\" = mkCmdKeybind "split" "Horizontal Split";

        "<leader>c" = mkLuaKeybind "function() require('mini.bufremove').delete(0, false) end" "Close Buffer";
        "<leader>C" = mkLuaKeybind "function() require('mini.bufremove').delete(0, true) end" "Close Buffer (Force)";
      };

      visual = {
        "<Tab>" = ">gv";
        "<S-Tab>" = "<gv";

        "K" = ":m '<-2<CR>gv=gv";
        "J" = ":m '>+1<CR>gv=gv";
      };
    };
  };
}
