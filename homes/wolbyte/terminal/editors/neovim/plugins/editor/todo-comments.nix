let
  helpers = import ../../helpers.nix;
in
  with helpers; {
    programs.nixvim = {
      plugins.todo-comments = {
        enable = true;

        keymaps = {
          todoTelescope.key = "<leader>ft";
          todoTrouble.key = "<leader>xt";
        };
      };

      keymaps = [
        (mkLuaKeymap "]t" ["n"] "function() require('todo-comments').jump_next() end" {desc = "Next todo comment";})
        (mkLuaKeymap "[t" ["n"] "function() require('todo-comments').jump_prev() end" {desc = "Previous todo comment";})
      ];
    };
  }
