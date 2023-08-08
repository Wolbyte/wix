{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.programs.desktop.telegram;
in {
  options.wb.programs.desktop.telegram = {
    enable = mkEnableOption "telegram";

    package = mkPackageOpt "telegram" pkgs.telegram-desktop;
  };

  config = mkIf cfg.enable {
    user.packages = [cfg.package];
  };
}
