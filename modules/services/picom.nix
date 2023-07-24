{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.services.picom;
in {
  options.wb.services.picom = {
    enable = mkEnableOption "picom";
    package = mkPackageOpt "picom" pkgs.picom;
  };

  config = mkIf cfg.enable {
    user.packages = [cfg.package];

    hm.xdg.configFile."picom.conf".text = ''
      backend = "glx";
      glx-no-stencil = true;

      fading = true;

      corner-radius = 10;

      vsync = true;
    '';
  };
}
