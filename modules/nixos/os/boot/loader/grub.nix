{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.wix.system.boot;

  theme = pkgs.wix.elegant-grub2-themes.override {
    theme = "mojave";
    type = "float";
    logo = "system";
  };
in
{
  config = mkIf (cfg.loader == "grub") {
    boot.loader.grub = {
      inherit (cfg) device;

      enable = true;

      default = "saved";

      useOSProber = true;

      efiSupport = true;

      theme = "${theme}/grub/themes/Elegant-mojave-float-left-dark";
    };
  };
}
