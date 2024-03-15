{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.wb.system.virtualization;
in {
  options.wb.system.virtualization = {
    enable = mkEnableOption "virtualization";

    distrobox.enable = mkEnableOption "distrobox";
    docker.enable = mkEnableOption "docker";
    libvirtd.enable = mkEnableOption "libvirtd";
    lxd.enable = mkEnableOption "lxd";
    podman.enable = mkEnableOption "podman";
    qemu.enable = mkEnableOption "qemu";
    waydroid.enable = mkEnableOption "waydroid";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      concatLists [
        (optionals cfg.distrobox.enable [
          distrobox
        ])

        (optionals cfg.docker.enable [
          docker-compose
          podman-compose
          podman-desktop
        ])

        (optionals cfg.qemu.enable [
          virt-manager
          virt-viewer
        ])

        (optionals cfg.waydroid.enable [
          waydroid
        ])
      ];

    virtualisation = {
      kvmgt.enable = true;
      spiceUSBRedirection.enable = true;

      containers.cdi.dynamic.nvidia.enable = config.wb.device.gpu == "nvidia";

      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          ovmf = {
            enable = true;
            packages = [pkgs.OVMFFull.fd];
          };
          swtpm.enable = true;
        };
      };

      podman = mkIf (cfg.docker.enable || cfg.podman.enable) {
        enable = true;

        dockerCompat = true;
        dockerSocket.enable = true;

        defaultNetwork.settings = {
          dns_enabled = true;
        };

        autoPrune = {
          enable = true;
          flags = ["--all"];
          dates = "weekly";
        };
      };

      lxd.enable = cfg.waydroid.enable || cfg.lxd.enable;
      waydroid.enable = cfg.waydroid.enable;
    };
  };
}
