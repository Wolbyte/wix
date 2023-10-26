{lib, ...}:
with lib;
with lib.wb; {
  imports = [
    ./hardware
    ./nix
    ./os
  ];

  options.wb.system = {
    video = {
      enable = mkEnableOption "graphical/video related features.";
    };
  };
}
