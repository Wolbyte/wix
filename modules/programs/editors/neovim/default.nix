{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.programs.editors.neovim;
in {
  options.wb.programs.editors.neovim = {
    enable = mkEnableOption "neovim";

    defaultEditor = defaultOpts.mkBool false "Whether to set `neovim` as the default editor";

    viAlias = defaultOpts.mkBool true "neovim vi alias";

    vimAlias = defaultOpts.mkBool true "neovim vim alias";
  };

  config = mkIf cfg.enable {
    env = mkIf cfg.defaultEditor {
      EDITOR = "nvim";
    };

    programs.nixvim = with cfg; {
      enable = true;
      inherit viAlias;
      inherit vimAlias;

      globals.format_on_save = true;

      extraConfigLua = ''
        vim.on_key(function(char)
          if vim.fn.mode() == "n" then
            local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
            if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
          end
        end, vim.api.nvim_create_namespace "auto_hlsearch")
      '';

      extraPlugins = with pkgs.vimPlugins; [
        bufdelete-nvim
        smart-splits-nvim
        yuck-vim
      ];
    };
  };

  imports = [
    inputs.nixvim.nixosModules.nixvim

    ./_nixvim/autocmds.nix

    ./_nixvim/colorschemes/rose-pine.nix

    ./_nixvim/languages

    ./_nixvim/mappings.nix
    ./_nixvim/options.nix

    ./_nixvim/plugins/alpha.nix
    ./_nixvim/plugins/bufferline.nix
    ./_nixvim/plugins/completion.nix
    ./_nixvim/plugins/editing-support.nix
    ./_nixvim/plugins/dap.nix
    ./_nixvim/plugins/git.nix
    ./_nixvim/plugins/indent-blankline.nix
    ./_nixvim/plugins/lsp
    ./_nixvim/plugins/lualine.nix
    ./_nixvim/plugins/neo-tree.nix
    ./_nixvim/plugins/notify.nix
    ./_nixvim/plugins/null-ls.nix
    ./_nixvim/plugins/nvim-autopairs.nix
    ./_nixvim/plugins/nvim-ufo.nix
    ./_nixvim/plugins/telescope.nix
    ./_nixvim/plugins/todo-comments.nix
    ./_nixvim/plugins/toggleterm.nix
    ./_nixvim/plugins/treesitter.nix
    ./_nixvim/plugins/trouble.nix
    ./_nixvim/plugins/which-key.nix
  ];
}
