let
  icons = import ../icons.nix;
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

    maps.normal = {
      "<leader>e" = {
        action = "<cmd>Neotree toggle<CR>";
        desc = "Toggle Explorer";
      };
      "<leader>o" = {
        action = ''
          function()
            if vim.bo.filetype == "neo-tree" then
              vim.cmd.wincmd "p"
            else
              vim.cmd.Neotree "focus"
            end
          end
        '';
        desc = "Toggle Explorer Focus";
        lua = true;
      };
    };
  };
}
