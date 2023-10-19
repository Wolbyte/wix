{
  self,
  lib,
  withSystem,
  ...
}:
with lib;
with lib.wb; let
  inherit (self) inputs;

  modulesPath = ../modules;

  coreModules = modulesPath + "/core";
  commonModules = coreModules + "/common";

  shared = [commonModules];

  homes = [];

  sharedArgs = {inherit inputs self lib;};
in
  foldl (acc: host:
    acc
    // {
      ${host.name} = mkHost {
        inherit withSystem;
        inherit (host) system;
        modules =
          [
            {networking.hostName = host.name;}
            (host.path or ./. + "/${host.name}")
          ]
          ++ (concatLists [shared (host.modules or []) (optionals host.includeHomes homes)]);
        specialArgs = sharedArgs;
      };
    }) {}
  (import ./definitions.nix {})
