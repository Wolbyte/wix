{
  pkgs,
  inputs,
  ...
}: {
  programs.nixvim = {
    enable = true;

    editorconfig.enable = true;

    extraPlugins = with pkgs.vimPlugins; [smart-splits-nvim];
  };

  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./autocmds.nix
    ./colorschemes/rose-pine.nix
    ./langs
    ./plugins
    ./keymaps.nix
    ./options.nix
  ];
}
