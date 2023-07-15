let
  icons = import ../icons.nix;
  helpers = import ../helpers.nix;
in {
  programs.nixvim = {
    plugins.gitsigns = with icons; {
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

    maps.normal = with helpers; {
      "<leader>g" = {desc = "Git";};
      "<leader>gl" = mkLuaKeybind "require('gitsigns').blame_line" "View Git blame";
      "<leader>gL" = mkLuaKeybind "function() require('gitsigns').blame_line { full = true } end" "View full Git blame";
      "<leader>gp" = mkLuaKeybind "require('gitsigns').preview_hunk" "Preview Git hunk";
      "<leader>gh" = mkLuaKeybind "require('gitsigns').reset_hunk" "Reset Git hunk";
      "<leader>gr" = mkLuaKeybind "require('gitsigns').reset_buffer" "Reset Git buffer";
      "<leader>gs" = mkLuaKeybind "require('gitsigns').stage_hunk" "Stage Git hunk";
      "<leader>gS" = mkLuaKeybind "require('gitsigns').stage_buffer" "Stage Git buffer";
      "<leader>gu" = mkLuaKeybind "require('gitsigns').undo_stage_hunk" "Unstage Git hunk";
      "<leader>gd" = mkLuaKeybind "require('gitsigns').diffthis" "View Git diff";
    };
  };
}
