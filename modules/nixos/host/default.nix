{ lib, config, ... }:
with lib;
let
  cfg = config.wix.host;

  allowedDesktopProfiles = [
    "desktop"
    "hybrid"
  ];
in
{
  options.wix.host = {
    profile = wix.defaultOpts.mkEnumFirstDefault [
      "none"
      "desktop"
      "server"
      "hybrid"
      "vm"
    ] "Customize features based on device type.";

    cpu = {
      vendor = wix.defaultOpts.mkEnumFirstDefault [
        null
        "amd"
        "amd-vm"
        "intel"
        "intel-vm"
      ] "Enables required ucode services and kernel modules based on the CPU vendor.";

      enableIGPU = wix.defaultOpts.mkBool true "Enables iGPU support.";
    };

    gpu = {
      vendor = wix.defaultOpts.mkEnumFirstDefault [
        null
        "nvidia"
        "nvidia-hybrid"
      ] "Configures graphics settings based on the vendor.";
    };

    bluetooth = {
      enable = wix.defaultOpts.mkBool true "Enable bluetooth support.";
    };

    enableSound = wix.defaultOpts.mkBool true "Enable sound support.";

    enableTPM = wix.defaultOpts.mkBool true "Enable TPM support.";

    displayServer = wix.defaultOpts.mkEnumFirstDefault [
      null
      "wayland"
    ] "Will enable specific services such as WMs, utils, etc.";

    desktopEnvironment = wix.defaultOpts.mkEnumFirstDefault [
      null
      "Hyprland"
    ] "The desktop envrionment to use.";

    enableDesktopFeatures = wix.defaultOpts.mkBool (builtins.elem cfg.profile allowedDesktopProfiles) "Whether to enable desktop related features.\n Turns on by default if `host.profile` is in the desktop profile list.";
  };
}
