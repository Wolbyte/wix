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

  sharedArgs = {
    inherit self inputs lib;
  };
  sharedModules = [ ../modules/nixos ];
  home-manager = [
    hmNixosModule
    ../homes
  ];
in
foldl (
  acc: host:
  let
    wixPackagesOverlay = final: prev: {
      wix = self.packages.${host.system};
    };

    definition = {
      ${host.name} = mkHost {
        inherit (host) name system extraUsers;
        inherit withSystem;

        modules =
          [
            {
              networking.hostName = host.name;
              nixpkgs.overlays = [ wixPackagesOverlay ];
            }

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
