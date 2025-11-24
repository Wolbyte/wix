{
  lib,
  config,
  ...
}:
with lib;
let
  inherit (config.wix) host;
in
{
  config = mkIf host.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;

      settings = {
        General = {
          # Show battery charge of connected devices on supported adapters
          Experimental = true;
        };

        Policy = {
          # Enable all adapters when they are connected
          AutoEnable = true;
        };
      };
    };

    services.blueman.enable = host.enableDesktopFeatures;
  };
}
