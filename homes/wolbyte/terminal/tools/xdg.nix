{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  browser = ["Schizofox.desktop"];
  fileManager = ["org.kde.dolphin.desktop"];
  zathura = ["org.pwmt.zathura.desktop.desktop"];

  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

    "inode/directory" = fileManager;
    "application/x-xz-compressed-tar" = ["org.kde.ark.desktop"];

    "audio/*" = ["mpv.desktop"];
    "video/*" = ["mpv.dekstop"];
    "image/*" = ["imv.desktop"];
    "application/json" = browser;
    "application/pdf" = zathura;
    "x-scheme-handler/tg" = ["telegramdesktop.desktop"];
    "x-scheme-handler/spotify" = ["spotify.desktop"];
    "x-scheme-handler/discord" = ["WebCord.desktop"];
  };
in {
  home.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_BIN_HOME = "$HOME/.local/bin";
  };

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
      documents = "$HOME/other";
      download = "$HOME/downloads";
      videos = "$HOME/videos";
      music = "$HOME/music";
      pictures = "$HOME/pictures";
      desktop = "$HOME/other";
      publicShare = "$HOME/other";
      templates = "$HOME/other";

      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/screenshots";
        XDG_DEV_DIR = "$HOME/dev";
      };
    };

    mimeApps = {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };

  home.packages = with pkgs;
    [
      xdg-utils
    ]
    ++ (optionals config.xdg.userDirs.enable [
      xdg-user-dirs
    ]);
}
