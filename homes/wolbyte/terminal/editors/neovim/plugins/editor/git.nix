let
  icons = import ../../icons.nix;
  helpers = import ../../helpers.nix;
in
  with helpers; {
    programs.nixvim = {
      plugins = {
        gitsigns = with icons; {
          enable = true;
          settings.signs = {
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

      keymaps = [
        # Gitsigns
        (mkLuaKeymap "<leader>gl" ["n"] "require('gitsigns').blame_line" {desc = "View Git blame";})
        (mkLuaKeymap "<leader>gL" ["n"] "function() require('gitsigns').blame_line { full = true } end" {desc = "View full Git blame";})
        (mkLuaKeymap "<leader>gp" ["n"] "require('gitsigns').preview_hunk" {desc = "Preview Git hunk";})
        (mkLuaKeymap "<leader>gh" ["n"] "require('gitsigns').reset_hunk" {desc = "Reset Git hunk";})
        (mkLuaKeymap "<leader>gr" ["n"] "require('gitsigns').reset_buffer" {desc = "Reset Git buffer";})
        (mkLuaKeymap "<leader>gs" ["n"] "require('gitsigns').stage_hunk" {desc = "Stage Git hunk";})
        (mkLuaKeymap "<leader>gS" ["n"] "require('gitsigns').stage_buffer" {desc = "Stage Git buffer";})
        (mkLuaKeymap "<leader>gu" ["n"] "require('gitsigns').undo_stage_hunk" {desc = "Unstage Git hunk";})

        # Diffview
        (mkCmdKeymap "<leader>gdo" ["n"] "DiffviewOpen" {desc = "Open Diffview";})
        (mkCmdKeymap "<leader>gdc" ["n"] "DiffviewClose" {desc = "Close Diffview";})
        (mkCmdKeymap "<leader>gdr" ["n"] "DiffviewRefresh" {desc = "Refresh Diffview";})
        (mkCmdKeymap "<leader>gdt" ["n"] "DiffviewToggleFiles" {desc = "Toggle Diffview files panel";})
        (mkCmdKeymap "<leader>gdf" ["n"] "DiffviewFocusFiles" {desc = "Focus Diffview files panel";})
        (mkCmdKeymap "<leader>gdh" ["n"] "DiffviewFileHistory %" {desc = "View history of the current file";})
        (mkCmdKeymap "<leader>gdH" ["n"] "DiffviewFileHistory" {desc = "View file history";})
      ];
    };
  }
