{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  homeDir = config.home.homeDirectory;
in
{
  xdg = {
    enable = true;

    dataHome = "${homeDir}/.local/share";
    cacheHome = "${homeDir}/.cache";
    configHome = "${homeDir}/.config";
    stateHome = "${homeDir}/.local/state";

    userDirs = {
      enable = true;

      createDirectories = true;

      download = "${homeDir}/downloads";
      videos = "${homeDir}/videos";
      music = "${homeDir}/music";
      pictures = "${homeDir}/pictures";

      desktop = "${homeDir}/other";
      documents = "${homeDir}/other";
      publicShare = "${homeDir}/other";
      templates = "${homeDir}/other";
    };
  };

  home.packages = with pkgs; [
    xdg-utils
    xdg-user-dirs
  ];
}
