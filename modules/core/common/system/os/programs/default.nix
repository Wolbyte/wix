{
  pkgs,
  lib,
  ...
}:
with lib;
with lib.wb; {
  imports = [./default-programs.nix];

  options.wb = {
    programs = {
      cli = {
        enable = defaultOpts.mkBool false "Enable CLI apps.";
      };

      gui = {
        enable = defaultOpts.mkBool false "Enable GUI apps.";
      };
    };
  };

  config = {
    programs = {
      bash = {
        promptInit = "eval $(${getExe pkgs.starship} init bash)";
      };

      less.enable = true;

      thefuck.enable = true;
    };
  };
}
