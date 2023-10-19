{
  pkgs,
  lib,
  ...
}: {
  programs = {
    bash = {
      promptInit = "eval $(${lib.getExe pkgs.starship} init bash)";
    };

    less.enable = true;

    thefuck.enable = true;
  };
}
