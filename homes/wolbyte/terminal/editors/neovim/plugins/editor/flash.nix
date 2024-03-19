let
  helpers = import ../../helpers.nix;
in
  with helpers; {
    programs.nixvim = {
      plugins.flash = {
        enable = true;
      };

      keymaps = [
        (mkLuaKeymap "s" ["n" "x" "o"] "function() require('flash').jump() end" {desc = "Flash";})
        (mkLuaKeymap "S" ["n" "x" "o"] "function() require('flash').treesitter() end" {desc = "Flash treesitter";})
        (mkLuaKeymap "r" ["o"] "function() require('flash').remote() end" {desc = "Flash remote";})
        (mkLuaKeymap "R" ["x" "o"] "function() require('flash').treesitter_search() end" {desc = "Treesitter search";})
        (mkLuaKeymap "<c-s>" ["c"] "function() require('flash').toggle() end" {desc = "Toggle flash search";})
      ];
    };
  }
