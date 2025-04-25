{ lib, config, ... }:
with lib;
let
  cfg = config.wix.system.filesystems;
in
{
  options.wix.system.filesystems = wix.mkOpt (types.listOf types.str) [ "ext4" "vfat" "ntfs" ] ''
    List of supported filsystems.
  '';

  config = mkMerge [
    (mkIf (builtins.elem "ext4" cfg) {
      boot = {
        supportedFilesystems.ext4 = true;
        initrd.supportedFilesystems.ext4 = true;
      };
    })

    (mkIf (builtins.elem "vfat" cfg) {
      boot = {
        supportedFilesystems.vfat = true;
        initrd.supportedFilesystems.vfat = true;
      };
    })

    (mkIf (builtins.elem "ntfs" cfg) {
      boot = {
        supportedFilesystems.ntfs = true;
      };
    })
  ];
}
