let
  helpers = import ../../helpers.nix;
in
  with helpers; {
    programs.nixvim = {
      plugins.trouble = {
        enable = true;

        settings.use_diagnostic_signs = true;
      };

      keymaps = [
        (mkCmdKeymap "<leader>xx" ["n"] "TroubleToggle document_diagnostics" {desc = "Document Diagnostics (Trouble)";})
        (mkCmdKeymap "<leader>xX" ["n"] "TroubleToggle workspace_diagnostics" {desc = "Workspace Diagnostics (Trouble)";})
        (mkCmdKeymap "<leader>xL" ["n"] "TroubleToggle loclist" {desc = "Location List (Trouble)";})
        (mkCmdKeymap "<leader>xQ" ["n"] "TroubleToggle quickfix" {desc = "Quickfix List (Trouble)";})
        (mkLuaKeymap "[q" ["n"] ''
          function()
            if require("trouble").is_open() then
              require("trouble").previous({skip_groups=true, jump=true})
            else
              local ok, err = pcall(vim.cmd.cprev)
              if not ok then
                vim.notify(err, vim.log.levels.ERROR)
              end
            end
          end
        '' {desc = "Previous trouble/quickfix item";})
        (mkLuaKeymap "]q" ["n"] ''
          function()
            if require("trouble").is_open() then
              require("trouble").next({skip_groups=true, jump=true})
            else
              local ok, err = pcall(vim.cmd.cnext)
              if not ok then
                vim.notify(err, vim.log.levels.ERROR)
              end
            end
          end
        '' {desc = "Next trouble/quickfix item";})
      ];
    };
  }
