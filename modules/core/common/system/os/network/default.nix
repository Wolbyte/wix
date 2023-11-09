{lib, ...}:
with lib; {
  services = {
    resolved.enable = true;
  };

  networking = {
    useDHCP = mkDefault false;

    useNetworkd = mkDefault true;

    networkmanager = {
      enable = true;
      plugins = [];
      dns = "systemd-resolved";
    };
  };

  systemd = {
    network.wait-online.enable = false;
    services = {
      NetworkManager-wait-online.enable = false;

      systemd-networkd.stopIfChanged = false;
      systemd-resolved.stopIfChanged = false;
    };
  };
}
