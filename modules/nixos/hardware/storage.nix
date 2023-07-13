{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.hardware.storage;
in {
  options.wb.hardware.storage = {
    enable = mkEnableOption "extra storage support";

    ssd = defaultOpts.mkBool false "Add tools for ssd management/performance.";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      services.udisks2.enable = true;

      environment.systemPackages = with pkgs; [
        sshfs
        exfat
        ntfs3g
      ];
    }

    (mkIf cfg.ssd {
      services.fstrim.enable = true;
    })
  ]);
}
