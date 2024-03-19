let
  icons = import ../../icons.nix;
  helpers = import ../../helpers.nix;
in
  with helpers; {
    programs.nixvim = {
      plugins.lspsaga = {
        enable = true;

        ui = {
          codeAction = icons.diagnosticHint;
          border = "rounded";
        };
      };

      keymaps = [
        (mkCmdKeymap "ca" ["n"] "Lspsaga code_action" {desc = "LSP Code Action";})
        (mkCmdKeymap "gd" ["n"] "Lspsaga goto_definition" {desc = "Goto Definition";})
        (mkCmdKeymap "gt" ["n"] "Lspsaga goto_type_definition" {desc = "Goto Type Definition";})
        (mkCmdKeymap "gp" ["n"] "Lspsaga peek_definition" {desc = "Peek Definition";})
        (mkCmdKeymap "gP" ["n"] "Lspsaga peek_type_definition" {desc = "Peek Type Definition";})
        (mkCmdKeymap "gr" ["n"] "Lspsaga rename" {desc = "LSP Rename";})
        (mkCmdKeymap "gR" ["n"] "Lspsaga rename ++project" {desc = "LSP Rename In All Files";})
      ];
    };
  }
