let
  helpers = import ../../helpers.nix;
in
  with helpers; {
    programs.nixvim = {
      plugins.bufferline = {
        enable = true;

        closeCommand.__raw = "function(n) require('mini.bufremove').delete(n, false) end";

        showCloseIcon = false;
        showBufferCloseIcons = false;

        maxNameLength = 14;
        maxPrefixLength = 13;

        offsets = [
          {
            filetype = "neo-tree";
            padding = 0;
            text = "File Explorer";
            separator = true;
          }
          {
            filetype = "dapui_scopes";
            padding = 0;
            text = "Debugger";
            separator = true;
          }
          {
            filetype = "dapui_breakpoints";
            padding = 0;
            text = "Debugger";
            separator = true;
          }
          {
            filetype = "dapui_stacks";
            padding = 0;
            text = "Debugger";
            separator = true;
          }
          {
            filetype = "dapui_watches";
            padding = 0;
            text = "Debugger";
            separator = true;
          }
        ];

        tabSize = 20;

        extraOptions = {
          separator_style = ["|" "|"];
          indicator.style = "none";
        };
      };

      keymaps = [
        (mkCmdKeymap "<A-l>" ["n"] "BufferLineCycleNext" {desc = "Cycle next buffer";})
        (mkCmdKeymap "<A-h>" ["n"] "BufferLineCyclePrev" {desc = "Cycle previous buffer";})
        (mkCmdKeymap "<A-s-l>" ["n"] "BufferLineMoveNext" {desc = "Move buffer to right";})
        (mkCmdKeymap "<A-s-h>" ["n"] "BufferLineMovePrev" {desc = "Move buffer to left";})
      ];
    };
  }
