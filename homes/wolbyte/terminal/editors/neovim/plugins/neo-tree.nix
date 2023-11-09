{lib, ...}: let
  icons = import ../icons.nix;
  helpers = import ../helpers.nix {inherit lib;};
in {
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;

      autoCleanAfterSessionRestore = true;
      closeIfLastWindow = true;
      sources = ["filesystem" "buffers" "git_status"];
      sourceSelector = {
        winbar = true;
        tabsLayout = "center";
        sources = [
          {
            source = "filesystem";
            displayName = "${icons.folderClosed} File";
          }
          {
            source = "buffers";
            displayName = "${icons.defaultFile} Bufs";
          }
          {
            source = "git_status";
            displayName = "${icons.git} Git";
          }
          {
            source = "diagnostics";
            displayName = "${icons.diagnostic} Diagnostic";
          }
        ];
      };

      defaultComponentConfigs = with icons; {
        indent.padding = 0;

        icon = {
          inherit (icons) folderClosed folderOpen folderEmpty folderEmptyOpen;
          default = defaultFile;
        };

        modified.symbol = fileModified;

        gitStatus.symbols = {
          added = gitAdd;
          deleted = gitDelete;
          modified = gitChange;
          renamed = gitRenamed;
          untracked = gitUntracked;
          ignored = gitIgnored;
          unstaged = gitUnstaged;
          staged = gitStaged;
          conflict = gitConflict;
        };
      };

      window.width = 30;

      filesystem = {
        hijackNetrwBehavior = "open_current";
        followCurrentFile.enabled = true;
        useLibuvFileWatcher = true;
      };

      popupBorderStyle = "rounded";
    };

    keymaps = with helpers;
      mkKeymaps {
        n = {
          "<leader>e" = mkCmdMap "Neotree toggle" "Toggle explorer";
          "<leader>o" =
            mkLuaMap ''
              function()
                if vim.bo.filetype == "neo-tree" then
                  vim.cmd.wincmd "p"
                else
                  vim.cmd.Neotree "focus"
                end
              end
            ''
            "Toggle Explorer Focus";
        };
      };
  };
}
