{
  pkgs,
  lib,
  ...
}:
with lib;
with lib.wb; {
  imports = [
    ./generic
    ./loader
  ];

  options.wb.system.boot = {
    device = defaultNullOpts.mkStr "nodev" "The device to install the bootloader to.";

    kernel = mkOpt types.raw pkgs.linuxPackages_6_1 "The kernel to use for the system.";

    loader = defaultOpts.mkEnumFirstDefault ["grub"] "Which bootloader to use.";

    silentBoot = defaultOpts.mkBool false "Silent boot process using the `quiet` kernel parameter.";
  };
}
