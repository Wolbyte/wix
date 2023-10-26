{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  sys = config.wb.system;
in {
  config = mkIf sys.video.enable {
    hardware = {
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
    };

    environment.systemPackages = with pkgs; [
      glxinfo
      glmark2
    ];
  };
}
