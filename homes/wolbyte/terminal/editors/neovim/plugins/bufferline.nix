{lib, ...}: let
  helpers = import ../helpers.nix {inherit lib;};
in {
  programs.nixvim = {
    plugins.bufferline = {
      enable = true;

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

    keymaps = with helpers;
      mkKeymaps {
        n = {
          "<A-l>" = mkCmdMap "BufferLineCycleNext" "Cycle next buffer";
          "<A-h>" = mkCmdMap "BufferLineCyclePrev" "Cycle previous buffer";
          "<A-s-l>" = mkCmdMap "BufferLineMoveNext" "Move buffer to right";
          "<A-s-h>" = mkCmdMap "BufferLineMovePrev" "Move buffer to left";
        };
      };
  };
}
