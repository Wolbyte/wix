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

      git = {
        signingKey = defaultOpts.mkStr "" "The default signing key.";
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
