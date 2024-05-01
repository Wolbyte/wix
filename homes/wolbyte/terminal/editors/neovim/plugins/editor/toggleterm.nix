let
  helpers = import ../../helpers.nix;
in
  with helpers; {
    programs.nixvim = {
      plugins.toggleterm = {
        enable = true;

        settings = {
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

          on_create = ''
            function()
              vim.opt.foldcolumn = "0"
              vim.opt.signcolumn = "no"
            end
          '';

          shading_factor = 3;

          direction = "float";

          float_opts.border = "rounded";
        };
      };

      keymaps = [
        (mkCmdKeymap "<leader>tf" ["n"] "ToggleTerm direction=float" {desc = "ToggleTerm float";})
        (mkCmdKeymap "<leader>th" ["n"] "ToggleTerm size=10 direction=horizontal" {desc = "ToggleTerm horizontal split";})
        (mkCmdKeymap "<leader>tv" ["n"] "ToggleTerm size=80 direction=vertical" {desc = "ToggleTerm vertical split";})
      ];
    };
  }
