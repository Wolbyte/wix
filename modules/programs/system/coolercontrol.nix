{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.programs.system.coolercontrol;
in {
  options.wb.programs.system.coolercontrol = {
    enable = mkEnableOption "coolercontrol";

    # TODO: change the package once available: https://nixpk.gs/pr-tracker.html?pr=248972
    package = mkPackageOpt "coolercontrol" pkgs.wb.coolercontrol.coolercontrold;

    gui = {
      enable = defaultOpts.mkBool false "coolercontrol-gui";

      # TODO: change the package once available: https://nixpk.gs/pr-tracker.html?pr=248972
      package = mkPackageOpt "coolercontrol-gui" pkgs.wb.coolercontrol.coolercontrol-gui;
    };

    liqctld = {
      enable = defaultOpts.mkBool cfg.enable "coolercontrol-gui";

      # TODO: change the package once available: https://nixpk.gs/pr-tracker.html?pr=248972
      package = mkPackageOpt "coolercontrol-liqctld" pkgs.wb.coolercontrol.coolercontrol-liqctld;
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      user.packages = [cfg.package];
    }

    (mkIf cfg.gui.enable {
      user.packages = [cfg.gui.package];
    })

    (mkIf cfg.liqctld.enable {
      user.packages = [cfg.liqctld.package];
    })
  ]);
}
