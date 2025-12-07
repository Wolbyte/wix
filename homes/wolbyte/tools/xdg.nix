{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  homeDir = config.home.homeDirectory;

  archiveViewer = [ "org.kde.ark.desktop" ];

  associations = {
    "image/*" = [ "imv.desktop" ];
    "video/*" = [ "mpv.desktop" ];
    "text/*" = [ "nvim.desktop" ];
    "x-scheme-handler/postman" = [ "Postman.desktop" ];
    "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
    "x-scheme-handler/tonsite" = [ "org.telegram.desktop.desktop" ];

    "application/gzip" = archiveViewer;
    "application/vnd.debian.binary-package" = archiveViewer;
    "application/vnd.efi.iso" = archiveViewer;
    "application/vnd.ms-cab-compressed" = archiveViewer;
    "application/vnd.rar" = archiveViewer;
    "application/x-7z-compressed" = archiveViewer;
    "application/x-archive" = archiveViewer;
    "application/x-arj" = archiveViewer;
    "application/x-bcpio" = archiveViewer;
    "application/x-bzip2" = archiveViewer;
    "application/x-bzip2-compressed-tar" = archiveViewer;
    "application/x-compress" = archiveViewer;
    "application/x-compressed-tar" = archiveViewer;
    "application/x-cpio" = archiveViewer;
    "application/x-lha" = archiveViewer;
    "application/x-lrzip" = archiveViewer;
    "application/x-lrzip-compressed-tar" = archiveViewer;
    "application/x-lz4" = archiveViewer;
    "application/x-lz4-compressed-tar" = archiveViewer;
    "application/x-lzip" = archiveViewer;
    "application/x-lzip-compressed-tar" = archiveViewer;
    "application/x-lzma" = archiveViewer;
    "application/x-lzma-compressed-tar" = archiveViewer;
    "application/x-lzop" = archiveViewer;
    "application/x-rpm" = archiveViewer;
    "application/x-stuffit" = archiveViewer;
    "application/x-sv4cpio" = archiveViewer;
    "application/x-sv4crc" = archiveViewer;
    "application/x-tar" = archiveViewer;
    "application/x-tarz" = archiveViewer;
    "application/x-tzo" = archiveViewer;
    "application/x-xar" = archiveViewer;
    "application/x-xz" = archiveViewer;
    "application/x-xz-compressed-tar" = archiveViewer;
    "application/x-zstd-compressed-tar" = archiveViewer;
    "application/zip" = archiveViewer;
    "application/zlib" = archiveViewer;
    "application/zstd" = archiveViewer;
  };
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

    mimeApps = {
      enable = true;

      associations.added = associations;

      defaultApplications = associations;
    };
  };

  home = {
    sessionVariables = {
      CUDA_CACHE_PATH = config.xdg.cacheHome + "/nv/";
      ANDROID_USER_HOME = config.xdg.dataHome + "/android/";
      NODE_REPL_HISTORY = config.xdg.stateHome + "/node_repl_history";
    };

    packages = with pkgs; [
      xdg-ninja
      xdg-utils
      xdg-user-dirs
    ];
  };
}
