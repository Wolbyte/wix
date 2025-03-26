{ pkgs }:
let
  inherit (pkgs) lib;

  builders = import ./builders.nix { inherit lib; };
  options = import ./options.nix { inherit lib; };
in
lib.extend (_: _: { wix = builders // options; })
