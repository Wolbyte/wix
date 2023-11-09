{
  pkgs,
  lib,
  ...
}: let
  helpers = import ../helpers.nix {inherit lib;};
  mkTelescopeBind = action: helpers.mkLuaMap ("require('telescope.builtin')." + action);
in {
  programs.nixvim = {
    plugins = {
      telescope = {
        enable = true;

        extensions.fzf-native = {
          enable = true;
          caseMode = "smart_case";
          fuzzy = true;
        };

        defaults = let
          mkAction = action: {__raw = "require('telescope.actions').${action}";};
        in {
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

          mappings = {
            i = {
              "<C-n>" = mkAction "cycle_history_next";
              "<C-p>" = mkAction "cycle_history_prev";
              "<C-j>" = mkAction "move_selection_next";
              "<C-k>" = mkAction "move_selection_previous";
              "<C-q>" = mkAction "close";
            };

            n."q" = mkAction "close";
          };
        };
      };
    };

    keymaps = with helpers;
      mkKeymaps {
        n = {
          "<leader>f<CR>" = mkTelescopeBind "resume" "Resume previous search";
          "<leader>f'" = mkTelescopeBind "marks" "Find marks";
          "<leader>fb" = mkTelescopeBind "buffers" "Find buffers";
          "<leader>fc" = mkTelescopeBind "grep_string" "Find for word under cursor";
          "<leader>fC" = mkTelescopeBind "commands" "Find commands";
          "<leader>ff" = mkTelescopeBind "find_files" "Find files";
          "<leader>fF" = mkLuaMap ''
            function()
              require('telescope.builtin').find_files { hidden = true, no_ignore = true }
            end
          '' "Find All Files";
          "<leader>fh" = mkTelescopeBind "help_tags" "Find help";
          "<leader>fk" = mkTelescopeBind "keymaps" "Find keymaps";
          "<leader>fm" = mkTelescopeBind "man_pages" "Find man";
          "<leader>fn" = mkLuaMap "require('telescope').extensions.notify.notify" "Find notifications";
          "<leader>fo" = mkTelescopeBind "oldfiles" "Find history";
          "<leader>fr" = mkTelescopeBind "registers" "Find registers";
          "<leader>fw" = mkTelescopeBind "live_grep" "Find words";
          "<leader>fW" = mkLuaMap ''
            function()
              require("telescope.builtin").live_grep {
                additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
              }
            end
          '' "Find words in all files";
        };
      };
  };

  home.packages = with pkgs; [
    fd
    ripgrep
  ];
}
