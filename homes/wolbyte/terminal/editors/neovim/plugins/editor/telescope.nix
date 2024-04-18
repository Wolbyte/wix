{pkgs, ...}: let
  helpers = import ../../helpers.nix;
in
  with helpers; {
    programs.nixvim = {
      plugins = {
        telescope = {
          enable = true;

          extensions.fzf-native = {
            enable = true;
            settings = {
              case_mode = "smart_case";
              fuzzy = true;
            };
          };

          settings = {
            defaults = {
              path_display = ["truncate"];
              sorting_strategy = "ascending";

              layout_config = {
                horizontal = {
                  prompt_position = "top";
                  preview_width = 0.55;
                };
                vertical = {mirror = false;};
                width = 0.87;
                height = 0.80;
                preview_cutoff = 120;
              };

              mappings = let
                mkAction = action: {__raw = "require('telescope.actions').${action}";};
              in {
                i = {
                  "<C-n>" = mkAction "cycle_history_next";
                  "<C-p>" = mkAction "cycle_history_prev";
                  "<C-j>" = mkAction "move_selection_next";
                  "<C-k>" = mkAction "move_selection_previous";
                  "<C-q>" = mkAction "close";
                  "<C-s>" = {__raw = "__telescope_flash";};
                };

                n = {
                  "s" = {__raw = "__telescope_flash";};
                  "q" = mkAction "close";
                };
              };
            };
          };
        };
      };

      extraConfigLuaPre = ''
        local function __telescope_flash(prompt_bufnr)
          require("flash").jump({
            pattern = "^",
            label = { after = { 0, 0 } },
            search = {
              mode = "search",
              exclude = {
                function(win)
                  return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
                end,
              },
            },
            action = function(match)
              local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
              picker:set_selection(match.pos[1] - 1)
            end,
          })
        end
      '';

      extraPackages = with pkgs; [
        fd
        ripgrep
      ];

      keymaps = [
        (mkLuaKeymap "<leader>f<CR>" ["n"] "require('telescope.builtin').resume" {desc = "Resume previous search";})
        (mkLuaKeymap "<leader>f'" ["n"] "require('telescope.builtin').marks" {desc = "Find marks";})
        (mkLuaKeymap "<leader>fb" ["n"] "require('telescope.builtin').buffers" {desc = "Find buffers";})
        (mkLuaKeymap "<leader>fc" ["n"] "require('telescope.builtin').grep_string" {desc = "Find word under cursor";})
        (mkLuaKeymap "<leader>fC" ["n"] "require('telescope.builtin').commands" {desc = "Find commands";})
        (mkLuaKeymap "<leader>ff" ["n"] "require('telescope.builtin').find_files" {desc = "Find files";})
        (mkLuaKeymap "<leader>fF" ["n"] "function() require('telescope.builtin').find_files{hidden=true, no_ignore=true} end" {desc = "Find all files";})
        (mkLuaKeymap "<leader>fh" ["n"] "require('telescope.builtin').help_tags" {desc = "Find help";})
        (mkLuaKeymap "<leader>fk" ["n"] "require('telescope.builtin').keymaps" {desc = "Find keymaps";})
        (mkLuaKeymap "<leader>fm" ["n"] "require('telescope.builtin').man_pages" {desc = "Find manual";})
        (mkLuaKeymap "<leader>fn" ["n"] "require('telescope').extensions.notify.notify" {desc = "Find notifications";})
        (mkLuaKeymap "<leader>fo" ["n"] "require('telescope.builtin').oldfiles" {desc = "Find history";})
        (mkLuaKeymap "<leader>fw" ["n"] "require('telescope.builtin').live_grep" {desc = "Find words";})
        (mkLuaKeymap "<leader>fW" ["n"] "function() require('telescope.builtin').live_grep {additional_args = function(args) return vim.list_extend(args, { '--hidden', '--no-ignore' }) end} end" {desc = "Find words in all files";})
      ];
    };
  }
