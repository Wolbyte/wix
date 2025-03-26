{
  inputs,
  lib,
  host,
  ...
}:
with lib;
{
  home-manager = mkIf host.useHomeManager {
    verbose = true;

    useUserPackages = true;

    useGlobalPkgs = true;

    extraSpecialArgs = { inherit inputs; };

    users = genAttrs host.extraUsers (name: ./${name});
  };
}
