{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  inherit (config.wix) host;
in
{
  config = mkIf (host.cpu.vendor == "amd" || host.cpu.vendor == "amd-vm") {
    hardware.cpu.amd.updateMicrocode = true;

    boot = mkMerge [
      {
        kernelModules = [ "kvm-amd" ];
        kernelParams = [ "amd_iommu=on" ];
      }
    ];

    environment.systemPackages = with pkgs; [ amdctl ];
  };
}
