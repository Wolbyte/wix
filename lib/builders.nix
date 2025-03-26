{ lib }:
{
  mkHost =
    {
      system,
      modules,
      withSystem,
      ...
    }@args:
    withSystem system (
      { self', inputs', ... }:
      lib.nixosSystem {
        inherit modules system;

        specialArgs = {
          inherit lib self' inputs';
        } // args.specialArgs or { };
      }
    );
}
