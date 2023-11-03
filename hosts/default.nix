{
  self,
  lib,
  withSystem,
  ...
}:
with lib;
with lib.wb; let
  inherit (self) inputs;

  hm = inputs.home-manager.nixosModules.home-manager;

  modulesPath = ../modules;

  coreModules = modulesPath + "/core";

  profileModules = coreModules + "/profiles";
  commonModules = coreModules + "/common";

  shared = [
    commonModules
    profileModules
  ];

  homesDir = ../homes;
  homes = [homesDir hm];

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
