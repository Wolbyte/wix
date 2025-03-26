{
  self,
  inputs,
  lib,
  withSystem,
  ...
}:
with lib;
with lib.wix;
let
  hmNixosModule = inputs.home-manager.nixosModules.home-manager;

  sharedArgs = { inherit self inputs lib; };
  sharedModules = [ ../modules/nixos ];
  home-manager = [
    hmNixosModule
    ../homes
  ];
in
foldl (
  acc: host:
  let
    definition = {
      ${host.name} = mkHost {
        inherit (host) name system extraUsers;
        inherit withSystem;

        modules =
          [
            { networking.hostName = host.name; }
            (host.path or ./. + "/${host.name}/")
          ]
          ++ sharedModules
          ++ (host.modules or [ ])
          ++ (optionals host.useHomeManager home-manager);

        specialArgs = sharedArgs // host.specialArgs or { } // { inherit host; };
      };
    };
  in
  acc // definition
) { } (import ./definitions.nix)
