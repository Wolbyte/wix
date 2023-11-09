{pkgs, inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./autocmds.nix
    ./colorschemes/rose-pine.nix
    ./languages
    ./mappings.nix
    ./options.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;

    globals.format_on_save = true;

    extraPlugins = with pkgs.vimPlugins; [
      smart-splits-nvim
      yuck-vim
    ];
  };
}
