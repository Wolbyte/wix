{
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.system.fs;
in {
  options.wb.system.fs = mkOpt (types.listOf types.str) ["vfat" "ext4" "ntfs"] ''
    A list of filesystems supported by the system.
  '';

  config = mkMerge [
    (mkIf (builtins.elem "ext4" cfg) {
      boot = {
        supportedFilesystems = ["ext4"];
        initrd = {
          supportedFilesystems = ["ext4"];
        };
      };
    })

    (mkIf (builtins.elem "exfat" cfg) {
      boot = {
        supportedFilesystems = ["exfat"];
        initrd = {
          supportedFilesystems = ["exfat"];
        };
      };
    })

    (mkIf (builtins.elem "vfat" cfg) {
      boot = {
        supportedFilesystems = ["vfat"];
        initrd = {
          supportedFilesystems = ["vfat"];
        };
      };
    })

    (mkIf (builtins.elem "ntfs" cfg) {
      boot = {
        supportedFilesystems = ["ntfs"];
      };
    })
  ];
}
