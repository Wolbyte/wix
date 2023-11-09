{lib, ...}: let
  icons = import ../../icons.nix;
  helpers = import ../../helpers.nix {inherit lib;};
in {
  programs.nixvim = {
    plugins.lspsaga = {
      enable = true;

      ui = {
        codeAction = icons.diagnosticHint;
        border = "rounded";
      };
    };

    keymaps = with helpers;
      mkKeymaps {
        n = {
          ca = mkCmdMap "Lspsaga code_action" "LSP Code Action";
          gd = mkCmdMap "Lspsaga goto_definition" "Goto Definition";
          gt = mkCmdMap "Lspsaga goto_type_definition" "Goto Type Definition";
          gp = mkCmdMap "Lspsaga peek_definition" "Peek Definition";
          gP = mkCmdMap "Lspsaga peek_type_definition" "Peek Type Definition";
          gr = mkCmdMap "Lspsaga rename" "LSP Rename";
          gR = mkCmdMap "Lspsaga rename ++project" "LSP Rename In All Files";
        };
      };
  };
}
