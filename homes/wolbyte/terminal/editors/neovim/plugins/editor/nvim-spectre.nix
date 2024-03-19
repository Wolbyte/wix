{pkgs, ...}: let
  helpers = import ../../helpers.nix;
in
  with helpers; {
    programs.nixvim = {
      extraPlugins = with pkgs.vimPlugins; [nvim-spectre];

      extraConfigLua = ''
        require("spectre").setup({
          open_cmd = "noswapfile vnew"
        })
      '';

      keymaps = [
        (mkLuaKeymap "<leader>fr" ["n"] "function() require('spectre').toggle() end" {desc = "Replace in files (spectre)";})
      ];
    };
  }
