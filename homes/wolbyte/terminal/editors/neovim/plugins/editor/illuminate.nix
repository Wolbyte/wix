let
  helpers = import ../../helpers.nix;
in
  with helpers; {
    programs.nixvim = {
      plugins.illuminate = {
        enable = true;

        delay = 200;

        largeFileCutoff = 2000;

        largeFileOverrides.providers = ["lsp"];
      };

      keymaps = [
        (mkLuaKeymap "]]" ["n"] "function() require('illuminate').goto_next_reference(false) end" {desc = "Goto next reference";})
        (mkLuaKeymap "[[" ["n"] "function() require('illuminate').goto_prev_reference(false) end" {desc = "Goto prev reference";})
      ];
    };
  }
