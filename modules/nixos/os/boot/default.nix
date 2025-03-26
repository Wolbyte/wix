{
  pkgs,
  lib,
  ...
}:
with lib;
{
  imports = [
    ./loader
    ./shared.nix
  ];

  options.wix.system.boot = {
    device = wix.defaultOpts.mkStr "nodev" "The bootloader target device.";

    kernelPackages = wix.mkOpt types.raw pkgs.linuxPackages_latest "Kernel packages to use.";

    loader = wix.defaultOpts.mkEnumFirstDefault [ "grub" ] "Sets preferred bootloader.";

    silentBoot = wix.defaultOpts.mkBool false "Add the `quiet` kernel parameter";
  };
}
