{
  pkgs,
  lib,
  ...
}: {
  imports = [./default-programs.nix];

  programs = {
    bash = {
      promptInit = "eval $(${lib.getExe pkgs.starship} init bash)";
    };

    less.enable = true;

    thefuck.enable = true;
  };
}
