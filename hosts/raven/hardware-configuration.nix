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

    kernelModules = [ "kvm-intel" ];

    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/bfe83c85-0c0a-48f1-b69b-9a4a4cf68789";
      fsType = "ext4";
    };

    "/home" = {
      device = "/dev/disk/by-uuid/d705c94c-3901-4ca2-b9a2-e208c030afb6";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/9040-25C5";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/99bfa3fa-c173-4927-bff9-fbc3d7c94b58"; }
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
