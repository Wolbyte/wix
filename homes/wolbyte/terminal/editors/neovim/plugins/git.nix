{lib, ...}: let
  icons = import ../icons.nix;
  helpers = import ../helpers.nix {inherit lib;};
in {
  programs.nixvim = {
    plugins = {
      gitsigns = with icons; {
        enable = true;
        signs = {
          add.text = gitSign;
          change.text = gitSign;
          delete.text = gitSign;
          topdelete.text = gitSign;
          changedelete.text = gitSign;
          untracked.text = gitSign;
        };
      };

      diffview.enable = true;
    };

    keymaps = with helpers;
      mkKeymaps {
        n = {
          # Gitsigns
          "<leader>gl" = mkLuaMap "require('gitsigns').blame_line" "View Git blame";
          "<leader>gL" = mkLuaMap "function() require('gitsigns').blame_line { full = true } end" "View full Git blame";
          "<leader>gp" = mkLuaMap "require('gitsigns').preview_hunk" "Preview Git hunk";
          "<leader>gh" = mkLuaMap "require('gitsigns').reset_hunk" "Reset Git hunk";
          "<leader>gr" = mkLuaMap "require('gitsigns').reset_buffer" "Reset Git buffer";
          "<leader>gs" = mkLuaMap "require('gitsigns').stage_hunk" "Stage Git hunk";
          "<leader>gS" = mkLuaMap "require('gitsigns').stage_buffer" "Stage Git buffer";
          "<leader>gu" = mkLuaMap "require('gitsigns').undo_stage_hunk" "Unstage Git hunk";

          # Diffview
          "<leader>gdo" = mkCmdMap "DiffviewOpen" "Open Diffview";
          "<leader>gdc" = mkCmdMap "DiffviewClose" "Close Diffview";
          "<leader>gdr" = mkCmdMap "DiffviewRefresh" "Refresh Diffview";
          "<leader>gdt" = mkCmdMap "DiffviewToggleFiles" "Toggle Diffview files panel";
          "<leader>gdf" = mkCmdMap "DiffviewFocusFiles" "Focus Diffview files panel";
          "<leader>gdh" = mkCmdMap "DiffviewFileHistory %" "View history of the current file";
          "<leader>gdH" = mkCmdMap "DiffviewFileHistory" "View file history";
        };
      };
  };
}
