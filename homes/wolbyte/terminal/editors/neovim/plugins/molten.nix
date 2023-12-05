{
  pkgs,
  lib,
  ...
}:
with lib; let
  helpers = import ../helpers.nix {inherit lib;};

  # TODO: Push patches to upstream

  moltenPackage = pkgs.vimPlugins.molten-nvim.overrideAttrs (oldAttrs: {
    passthru.python3Dependencies = ps:
      with ps; [
        pynvim
        nbformat
        jupyter-client
        ueberzug
        pillow
        cairosvg
        plotly
        ipykernel
        pyperclip
        pnglatex
      ];
  });
in {
  programs.nixvim = {
    plugins = {
      molten = {
        enable = true;

        package = moltenPackage;
      };

      which-key = {
        registrations."<leader>m" = "Molten";
      };
    };

    globals = {
      molten_image_provider = mkForce "image.nvim";
    };

    extraPlugins = with pkgs.vimPlugins; [
      image-nvim
    ];

    extraConfigLua = ''
      require("image").setup {}

      vim.g.python3_host_prog = os.getenv("VIRTUAL_ENV") ~= nil and vim.fn.expand("$VIRTUAL_ENV/bin/python3") or vim.g.python3_host_prog
    '';

    keymaps = with helpers; (mkKeymaps {
        options = {
          silent = true;
          noremap = true;
        };
      } {
        n = {
          "<leader>mE" = mkCmdMap "MoltenEvaluateOperator" "Evaluate operator";
          "<leader>me" = mkCmdMap "MoltenEvaluateLine" "Evaluate line";
          "<leader>mc" = mkCmdMap "MoltenReevaluateCell" "Re-evaluate cell";
          "<leader>mi" = mkCmdMap "MoltenInit" "Initialize molten";
          "<leader>mI" = mkCmdMap "MoltenDeinit" "Deinit molten";
        };

        v = {
          "<leader>me" = mkRawMap ":<C-u>MoltenEvaluateVisual<CR>gv" "Molten evaluate selection";
        };
      });
  };
}
