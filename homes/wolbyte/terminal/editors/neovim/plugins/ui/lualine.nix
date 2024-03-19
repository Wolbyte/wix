let
  icons = import ../../icons.nix;

  conditions = {
    hideInWidth.__raw = "function() return vim.fn.winwidth(0) > 80 end";
  };

  components = {
    attachedClients.__raw = ''
      function()
        local buf_client_names = {}

        local buf_clients = vim.lsp.buf_get_clients()
        local linters = require("lint").linters_by_ft[vim.bo.filetype]
        local formatters = require("conform").list_formatters(0)
        local _, null_ls = pcall(require, "none-ls")

        if #formatters > 0 then
          for _, formatter in pairs(formatters) do
            table.insert(buf_client_names, formatter.name)
          end
        end

        if #linters > 0 then
          for _, linter in pairs(linters) do
            table.insert(buf_client_names, linter)
          end
        end

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

        sections = {
          lualine_a = [
            {
              name = "mode";
              extraConfig = {
                fmt.__raw = "function(str) return string.gsub(' '..string.lower(str), '%W%l', string.upper):sub(2) end";
              };
            }
          ];

          lualine_b = [
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

          lualine_c = [
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

          lualine_x = [
            "encoding"
            "fileformat"
            "filetype"
          ];

          lualine_y = [
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
              name = components.attachedClients;
            }
          ];

          lualine_z = ["progress" "location"];
        };
      };
    };
  }
