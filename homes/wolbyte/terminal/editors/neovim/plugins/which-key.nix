{
  config,
  lib,
  ...
}:
with lib; let
  nixvimPlugs =
    if builtins.hasAttr "plugins" config.nixvim
    then config.nixvim.plugins
    else config.programs.nixvim.plugins;
in {
  programs.nixvim = {
    plugins.which-key = {
      enable = true;

      registrations = with nixvimPlugs; {
        "<leader>d" = optionalString dap.enable "Debug";
        "<leader>f" = optionalString telescope.enable "Find";
        "<leader>g" = optionalString gitsigns.enable "Git";
        "<leader>gd" = optionalString diffview.enable "Diffview";
        "<leader>t" = optionalString toggleterm.enable "Terminal";
      };

      icons = {
        separator = "";
        group = "";
      };

      window.border = "rounded";
    };
  };
}
