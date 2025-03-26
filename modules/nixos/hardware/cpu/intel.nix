{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  host = config.wix.host;
in
{
  config = mkIf (host.cpu.vendor == "intel" || host.cpu.vendor == "intel-vm") {
    hardware.cpu.intel.updateMicrocode = true;

    boot = {
      kernelModules = [ "kvm-intel" ];
      kernelParams = optionals host.cpu.enableIGPU [
        "i915.fastboot=1"
        "enable_gvt=1"
      ];
    };

    environment.systemPackages = optionals host.cpu.enableIGPU [ pkgs.intel-gpu-tools ];
  };
}
