{
  self,
  pkgs,
  lib,
  config,
  modulesPath,
  ...
}:
with lib;
let
  hostName = config.networking.hostName or "nixos";
  nixosRelease = config.system.nixos.release;
  rev = self.shortRev or "${builtins.substring 0 8 self.lastModifiedDate}";
  imageName = "${hostName}-${nixosRelease}-${rev}-${pkgs.stdenv.hostPlatform.uname.processor}";
in
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  config = {
    image.fileName = mkImageMediaOverride "${imageName}.iso";

    isoImage = {
      volumeID = mkImageMediaOverride imageName;

      makeEfiBootable = true;

      makeUsbBootable = true;

      squashfsCompression = "zstd -Xcompression-level 10";
    };

    boot.supportedFilesystems = lib.mkForce [
      "btrfs"
      "reiserfs"
      "vfat"
      "f2fs"
      "xfs"
      "ntfs"
      "cifs"
    ];
  };
}
