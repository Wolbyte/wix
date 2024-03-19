let
  helpers = import ../../helpers.nix;
in
  with helpers; {
    programs.nixvim = {
      plugins.mini = {
        enable = true;

        modules = {
          bufremove = {};

          comment = {
            custom_commentstring.__raw = ''
              function()
                return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
              end
            '';
          };

          indentscope = {
            symbol = "│";
            options.try_as_border = true;
          };

          pairs = {};

          surround = {
            mappings = {
              add = "gsa";
              delete = "gsd";
              find = "gsf";
              find_left = "gsF";
              highlight = "gsh";
              replace = "gsr";
              update_n_lines = "gsn";
            };
          };
        };
      };

      keymaps = let
        bufCloseFunc = ''
          function()
            local bd = require("mini.bufremove").delete
            if vim.bo.modified then
              local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
              if choice == 1 then -- Yes
                vim.cmd.write()
                bd(0)
              elseif choice == 2 then -- No
                bd(0, true)
              end
            else
              bd(0)
            end
          end
        '';
      in [
        (mkLuaKeymap "<leader>bc" ["n"] bufCloseFunc {desc = "Close buffer";})
        (mkLuaKeymap "<leader>c" ["n"] bufCloseFunc {desc = "Close buffer";})

        (mkLuaKeymap "<leader>bC" ["n"] "function() require('mini.bufremove').delete(0, true) end" {desc = "Close buffer (Force)";})
      ];
    };
  }
