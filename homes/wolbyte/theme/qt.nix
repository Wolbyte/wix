{ pkgs, ... }:
let
  qtctConf = {
    Appearance = {
      icon_theme = "rose-pine";

      style = "kvantum-dark";

      standard_dialogs = "xdgdesktopportal";
    };
  };
in
{
  home = {
    packages = with pkgs; [
      libsForQt5.qt5ct
      qt6Packages.qt6ct

      libsForQt5.qtstyleplugin-kvantum
      qt6Packages.qtstyleplugin-kvantum
    ];

    sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt5ct:qt6ct";
    };
  };

  xdg.configFile = {
    "kdeglobals".source = (pkgs.formats.ini { }).generate "kdeglobals" {
      General.TerminalApplication = "kitty";

      Icons.theme = "rose-pine";
    };

    "qt5ct/qt5ct.conf".source = (pkgs.formats.ini { }).generate "qt5ct.conf" qtctConf;

    "qt6ct/qt6ct.conf".source = (pkgs.formats.ini { }).generate "qt6ct.conf" qtctConf;

    "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
      General.theme = "rose-pine-iris";
    };

    "Kvantum/rose-pine-iris".source = "${pkgs.rose-pine-kvantum}/share/Kvantum/themes/rose-pine-iris";
  };
}
