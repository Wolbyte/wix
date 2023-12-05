{lib, ...}: let
  helpers = import ../helpers.nix {inherit lib;};
in {
  programs.nixvim = {
    plugins.toggleterm = {
      enable = true;

      highlights = {
        Normal = {link = "Normal";};
        NormalNC = {link = "NormalNC";};
        NormalFloat = {link = "NormalFloat";};
        FloatBorder = {link = "FloatBorder";};
        StatusLine = {link = "StatusLine";};
        StatusLineNC = {link = "StatusLineNC";};
        WinBar = {link = "WinBar";};
        WinBarNC = {link = "WinBarNC";};
      };

      size = 10;

      onCreate = ''
        function()
          vim.opt.foldcolumn = "0"
          vim.opt.signcolumn = "no"
        end
      '';

      shadingFactor = 3;

      direction = "float";

      floatOpts.border = "rounded";
    };

    keymaps = with helpers;
      mkKeymaps {} {
        n = {
          "<leader>tf" = mkCmdMap "ToggleTerm direction=float" "ToggleTerm float";
          "<leader>th" = mkCmdMap "ToggleTerm size=10 direction=horizontal" "ToggleTerm horizontal split";
          "<leader>tv" = mkCmdMap "ToggleTerm size=80 direction=vertical" "ToggleTerm vertical split";
        };
      };
  };
}
