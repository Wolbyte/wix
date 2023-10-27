{
  config,
  inputs,
  inputs',
  lib,
  self,
  self',
  ...
}:
with lib; let
  inherit (config.wb) env;
in {
  home-manager = mkIf env.enableHomeManager {
    verbose = true;
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs self inputs' self';};
    users = genAttrs config.wb.system.users (name: ./${name});
  };
}
