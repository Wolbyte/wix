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
      services = {
        gvfs.enable = true;
        udisks2.enable = true;
      };

      environment.systemPackages = with pkgs; [
        exfat
        ntfs3g
        sshfs
      ];
    }

    (mkIf cfg.ssd {
      services.fstrim.enable = true;
    })
  ]);
}
