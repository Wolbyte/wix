{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.services.tumbler;
in {
  options.wb.services.tumbler = {
    enable = mkEnableOption "tumbler";
  };

  config = mkIf cfg.enable {
    services.tumbler.enable = true;

    user.packages = with pkgs; [
      ffmpegthumbnailer
    ];
  };
}
