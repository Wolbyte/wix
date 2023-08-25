let
  helpers = import ../helpers.nix;
in {
  programs.nixvim = {
    plugins.trouble = {
      enable = true;

      useDiagnosticSigns = true;
    };

    maps.normal = {
      "<leader>T" = helpers.mkCmdKeybind "TroubleToggle" "Toggle Trouble";
    };
  };
}
