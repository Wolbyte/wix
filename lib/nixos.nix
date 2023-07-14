{
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.wb; {
  mkHost = path: attrs @ {system ? pkgs.system, ...}:
    nixosSystem {
      inherit system;
      specialArgs = {
        inherit lib inputs system;
        inherit (inputs) nix-colors;
      };
      modules = [
        {
          options.host.name = defaultOpts.mkStr "" "The name of the host.";
          config = {
            nixpkgs.pkgs = pkgs;
            networking.hostName = mkDefault (getFileNameFromPath path);
            host.name = getFileNameFromPath path;
          };
        }
        (filterAttrs (n: v: !elem n ["system"]) attrs)
        ../.
        (import path)
      ];
    };

  mapHosts = dir: attrs @ {system ? pkgs.system, ...}:
    mapFiles dir (host: mkHost host attrs);
}
