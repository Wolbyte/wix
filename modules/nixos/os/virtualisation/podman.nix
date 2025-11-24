{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  inherit (config.wix) host;

  acceptedProfiles = [
    "desktop"
    "server"
    "hybrid"
  ];
in
{
  config = mkIf (builtins.elem host.profile acceptedProfiles) {
    virtualisation = {
      podman = {
        enable = true;

        dockerCompat = true;
        dockerSocket.enable = true;

        defaultNetwork.settings.dns_enabled = true;
      };
    };

    hardware.nvidia-container-toolkit.enable = builtins.any (
      driver: driver == "nvidia"
    ) config.services.xserver.videoDrivers;

    environment.systemPackages = with pkgs; [
      podman-desktop
      podman-compose
      docker-compose
    ];
  };
}
