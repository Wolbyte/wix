{lib, ...}: let
  helpers = import ../helpers.nix {inherit lib;};
in {
  programs.nixvim = {
    plugins.trouble = {
      enable = true;

      useDiagnosticSigns = true;
    };

    keymaps = with helpers;
      mkKeymaps {} {
        n = {
          "<leader>T" = helpers.mkCmdMap "TroubleToggle" "Toggle Trouble";
        };
      };
  };
}
