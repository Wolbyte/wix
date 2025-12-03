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

  home.sessionVariables = {
    CUDA_CACHE_PATH = config.xdg.cacheHome + "/nv/";
    ANDROID_USER_HOME = config.xdg.dataHome + "/android/";
    NODE_REPL_HISTORY = config.xdg.stateHome + "/node_repl_history";
  };

  home.packages = with pkgs; [
    xdg-ninja
    xdg-utils
    xdg-user-dirs
  ];
}
