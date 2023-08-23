let
  icons = import ../../icons.nix;
  helpers = import ../../helpers.nix;
in {
  programs.nixvim = {
    plugins.lspsaga = {
      enable = true;

      ui = {
        codeAction = icons.diagnosticHint;
        border = "rounded";
      };
    };

    maps = {
      normal = with helpers; {
        ca = mkCmdKeybind "Lspsaga code_action" "LSP Code Action";
        gd = mkCmdKeybind "Lspsaga goto_definition" "Goto Definition";
        gt = mkCmdKeybind "Lspsaga goto_type_definition" "Goto Type Definition";
        gp = mkCmdKeybind "Lspsaga peek_definition" "Peek Definition";
        gP = mkCmdKeybind "Lspsaga peek_type_definition" "Peek Type Definition";
        gr = mkCmdKeybind "Lspsaga rename" "LSP Rename";
        gR = mkCmdKeybind "Lspsaga rename ++project" "LSP Rename In All Files";
      };
    };
  };
}
