{ lib, ... }:
with lib;
{
  services.resolved.enable = true;

  networking = {
    useDHCP = mkDefault false;

    useNetworkd = mkDefault true;

    networkmanager = {
      enable = true;

      plugins = [ ];

      dns = "systemd-resolved";
    };
  };

  # fixes networkd timeouts with podman enabled
  systemd = {
    network.wait-online.enable = false;

    services = {
      NetworkManager-wait-online.enable = false;
    };
  };
}
