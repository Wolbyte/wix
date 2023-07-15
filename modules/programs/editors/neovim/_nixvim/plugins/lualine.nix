let
  icons = import ../icons.nix;

  conditions = {
    hideInWidth.__raw = "function() return vim.fn.winwidth(0) > 80 end";
  };

  components = {
    lsp.__raw = ''
      function()
        local msg = 'No Lsp'
        local buf_clients = vim.lsp.buf_get_clients()
        local null_ls_installed, null_ls = pcall(require, "null-ls")
        local buf_client_names = {}
        for _, client in pairs(buf_clients) do
          if client.name == "null-ls" then
            for _, source in ipairs(null_ls.get_source({ filetype = vim.bo.filetype })) do
              table.insert(buf_client_names, source.name)
            end
          else
            table.insert(buf_client_names, client.name)
          end
        end
        return table.concat(buf_client_names, ',')
      end
    '';
  };
in
  with icons; {
    programs.nixvim = {
      plugins.lualine = {
        enable = true;

        globalstatus = true;

        sectionSeparators = {
          left = "";
          right = "";
        };

        componentSeparators = {
          left = "|";
          right = "|";
        };

        sections.lualine_a = [
          {
            name = "mode";
            extraConfig = {
              fmt.__raw = "function(str) return string.gsub(' '..string.lower(str), '%W%l', string.upper):sub(2) end";
            };
          }
        ];

        sections.lualine_b = [
          {
            name = "branch";
            icon = gitBranch;
          }
          {
            name = "diff";
            extraConfig = {
              symbols = {
                added = "${gitAdd} ";
                modified = "${gitChange} ";
                removed = "${gitDelete} ";
              };
              cond = conditions.hideInWidth;
            };
          }
        ];

        sections.lualine_c = [
          {
            name = "filename";
            extraConfig = {
              newfile_status = true;
              symbols = {
                modified = fileModified;
                readonly = fileReadOnly;
                newfile = fileNew;
              };
            };
          }
        ];

        sections.lualine_x = [
          "encoding"
          "fileformat"
          "filetype"
        ];

        sections.lualine_y = [
          {
            name = "diagnostics";
            extraConfig = {
              symbols = {
                error = "${diagnosticError} ";
                warn = "${diagnosticWarn} ";
                info = "${diagnosticInfo} ";
                hint = "${diagnosticHint} ";
              };
            };
          }
          {
            name = components.lsp;
            icon = activeLSP;
          }
        ];

        sections.lualine_z = ["progress" "location"];
      };
    };
  }
