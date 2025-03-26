{
  pkgs,
  lib,
  ...
}:
with lib;
let

  sharedPacakges = with pkgs; [
    telegram-desktop
    libsForQt5.ark
  ];
in
{
  home.packages = mkMerge [
    sharedPacakges
  ];
}
