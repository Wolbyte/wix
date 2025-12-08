{
  lib,
  config,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];

    initrd.kernelModules = [ ];

    kernelModules = [ "kvm-amd" ];

    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/1DFC-1283";
      fsType = "ext4";
    };

    "/home" = {
      device = "/dev/disk/by-uuid/1DFC-1535";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/221003D31003AD3B";
      fsType = "ntfs";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };

  # swapDevices = [
  #   { device = "/dev/disk/by-uuid/99bfa3fa-c173-4927-bff9-fbc3d7c94b58"; }
  # ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
