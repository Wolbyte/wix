let
  helpers = import ../../helpers.nix;
in
  with helpers; {
    programs.nixvim = {
      plugins.nvim-ufo = {
        enable = true;

        preview = {
          mappings = {
            scrollB = "<C-b>";
            scrollF = "<C-f>";
            scrollU = "<C-u>";
            scrollD = "<C-d>";
          };
        };

        providerSelector = ''
          function(_, filetype, buftype)
            return {"treesitter", "indent"}
          end,
        '';
      };

      keymaps = [
        (mkLuaKeymap "zR" ["n"] "require('ufo').openAllFolds" {desc = "Open all folds (nvim-ufo)";})
        (mkLuaKeymap "zM" ["n"] "require('ufo').closeAllFolds" {desc = "Close all folds (nvim-ufo)";})
      ];
    };
  }
