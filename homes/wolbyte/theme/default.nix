{inputs, ...}: let
  inherit (inputs.nix-colors) colorSchemes;
in {
  imports = [
    inputs.nix-colors.homeManagerModule
    ./global.nix
    ./gtk.nix
    ./qt.nix
  ];

  # TODO: find a more proper base16 theme for rose-pine
  colorscheme = colorSchemes.rose-pine;
}
