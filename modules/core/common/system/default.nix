{lib, ...}:
with lib;
with lib.wb; {
  imports = [
    ./nix
    ./os
  ];

  options.wb.system = {
    video = {
      enable = mkEnableOption "graphical/video related features.";
    };
  };
}
