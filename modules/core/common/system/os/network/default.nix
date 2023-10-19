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
}
