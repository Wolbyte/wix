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
          nixpkgs.pkgs = pkgs;
          networking.hostName = mkDefault (getFileNameFromPath path);
        }
        (filterAttrs (n: v: !elem n ["system"]) attrs)
        ../.
        (import path)
      ];
    };

  mkHome = path: attrs @ {system ? pkgs.system, ...}:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs lib;

      modules = [
        (filterAttrs (n: v: !elem n ["system"]) attrs)
        (builtins.dirOf path)
        (import path)
      ];

      extraSpecialArgs = {
        inherit inputs;
      };
    };

  mapHosts = dir: attrs @ {system ? pkgs.system, ...}:
    mapFiles dir (host: mkHost host attrs);

  mapHomes = dir: attrs @ {system ? pkgs.system, ...}:
    builtins.listToAttrs (mapFilesRecursivePred'
      dir
      (n: v: v == "directory" && !(hasPrefix "_" n))
      (n: v: v != null && !(hasPrefix "_" n) && hasSuffix ".nix" v)
      (home: let
        name = "${baseNameOf (builtins.dirOf home)}@${getFileNameFromPath home}";
      in {
        name = builtins.unsafeDiscardStringContext name;
        value = mkHome home attrs;
      }));
}
