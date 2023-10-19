{
  inputs,
  lib,
  ...
}: let
  inherit (inputs) self;
in rec {
  mkSystem = lib.nixosSystem;

  mkHost = {
    modules,
    system,
    withSystem,
    ...
  } @ args:
    withSystem system ({
      inputs',
      self',
      ...
    }:
      mkSystem {
        inherit modules system;
        specialArgs = {inherit lib inputs self inputs' self';} // args.specialArgs or {};
      });
}
