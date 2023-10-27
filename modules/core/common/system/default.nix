{lib, ...}:
with lib;
with lib.wb; {
  imports = [
    ./hardware
    ./media
    ./nix
    ./os
  ];

  options.wb.system = {
    audio = {
      enable = mkEnableOption "audio related features";
    };

    video = {
      enable = mkEnableOption "graphical/video related features";
    };

    users = mkOpt (types.listOf types.str) ["wolbyte"] "List of home-manager users on the system.";
  };
}
