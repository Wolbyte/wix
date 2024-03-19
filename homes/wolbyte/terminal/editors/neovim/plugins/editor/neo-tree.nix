let
  helpers = import ../../helpers.nix;
  icons = import ../../icons.nix;
in
  with helpers; {
    programs.nixvim = {
      plugins.neo-tree = {
        enable = true;

        defaultComponentConfigs = with icons; {
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

          icon = {
            inherit (icons) folderClosed folderOpen folderEmpty folderEmptyOpen;
            default = defaultFile;
          };

          indent.withExpanders = true;

          modified.symbol = fileModified;
        };

        eventHandlers = rec {
          file_moved = ''
            function(data)
              __lsp_on_rename(data.source, data.destination)
            end
          '';

          file_renamed = file_moved;
        };

        filesystem = {
          followCurrentFile.enabled = true;
          useLibuvFileWatcher = true;
        };

        popupBorderStyle = "rounded";

        sources = ["filesystem" "buffers" "git_status" "document_symbols"];

        window = {
          mappings = {
            "<space>" = "none";
            "Y" = {
              __raw = ''
                function(state)
                  local node = state.tree:get_node()
                  local path = node:get_id()
                  vim.fn.setreg("+", path, "c")
                end
              '';
              desc = "Copy path to clipboard";
            };
          };
        };

        extraOptions = {
          open_files_do_not_replace_types = ["terminal" "Trouble" "trouble" "qf" "Outline"];
        };
      };

      keymaps = [
        (mkCmdKeymap "<leader>e" ["n"] "Neotree toggle" {desc = "Toggle explorer";})
      ];
    };
  }
