{lib, ...}: let
  leader = "SPC";

  mkBtn = shortcut: val: action: let
    sc = builtins.replaceStrings [" " leader] ["" "<leader>"] shortcut;
    keyOpts = {
      noremap = true;
      silent = true;
      nowait = true;
    };
  in {
    type = "button";
    inherit val;
    opts = {
      position = "center";
      inherit shortcut;
      keymap = lib.optionals (!builtins.isNull action) ["n" sc action keyOpts];
      cursor = 3;
      width = 50;
      hl_shortcut = "Keyword";
      align_shortcut = "right";
    };
    on_press.__raw = ''
      function()
        local key = vim.api.nvim_replace_termcodes(${
        if (!builtins.isNull action)
        then "\"${action}\""
        else "nil"
      } or "${sc}" .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
      end
    '';
  };
in {
  programs.nixvim = {
    plugins.alpha = {
      enable = true;

      layout = [
        {
          type = "padding";
          val = 10;
        }
        {
          opts = {
            hl = "Type";
            position = "center";
          };
          type = "text";
          val = [
            "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗"
            "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║"
            "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║"
            "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
            "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
            "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
          ];
        }
        {
          type = "padding";
          val = 2;
        }
        {
          type = "group";
          opts.position = "center";
          val = [
            (mkBtn "n" "  New file" "<CMD>ene<CR>")
            (mkBtn "SPC f f" "󰈞  Find file" null)
            (mkBtn "SPC f o" "󰊄  Recently opened files" null)
            (mkBtn "SPC f w" "󰈬  Find word" null)
            (mkBtn "${leader} q" "󰗼  Quit Neovim" null)
          ];
        }
      ];
    };
  };
}
