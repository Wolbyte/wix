{inputs, ...}: let
  inherit (inputs.nix-colors) colorSchemes;
in {
  imports = [
    inputs.nix-colors.homeManagerModule
    ./global.nix
    ./gtk.nix
    ./qt.nix
  ];

  colorscheme = colorSchemes.rose-pine;
  # colorscheme = colorSchemes.catppuccin-mocha;
}
