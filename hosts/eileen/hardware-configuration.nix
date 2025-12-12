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
      device = "/dev/disk/by-uuid/8f9de468-db54-45cf-a073-6643faf341bf";
      fsType = "ext4";
    };

    "/home" = {
      device = "/dev/disk/by-uuid/8df1c1c9-c497-47ef-bc07-2abadaffbe22";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/FA03-2408";
      fsType = "vfat";
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
