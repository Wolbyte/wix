{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  inherit (config.wb) device;
in {
  config = mkIf (device.cpu.vendor == "intel" || device.cpu.vendor == "intel-vm") {
    hardware.cpu.intel.updateMicrocode = true;

    boot = {
      kernelModules = ["kvm-intel"];
      kernelParams = optionals device.cpu.hasIntegratedGraphics ["i915.fastboot=1" "enable_gvt=1"];
    };

    environment.systemPackages = with pkgs; optionals device.cpu.hasIntegratedGraphics [intel-gpu-tools];
  };
}
