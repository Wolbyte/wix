{
  nixpkgs,
  inputs,
  ...
}: let
  inherit (nixpkgs) lib;

  builders = import ./builders.nix {inherit inputs lib;};
  helpers = import ./helpers.nix {inherit lib;};
  options = import ./options.nix {inherit lib;};
in
  nixpkgs.lib.extend (_: _: {wb = builders // helpers // options;})
