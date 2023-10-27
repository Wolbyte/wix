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
  defaults = config.wb.programs.default;
in {
  home-manager = mkIf env.enableHomeManager {
    verbose = true;
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit defaults inputs inputs' self self';};
    users = genAttrs config.wb.system.users (name: ./${name});
  };
}
