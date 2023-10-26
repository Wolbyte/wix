{lib, ...}:
with lib;
with lib.wb; {
  options.wb.device = {
    profile = defaultOpts.mkEnumFirstDefault [null "desktop" "hybrid" "server" "vm"] ''
      The type of the device that will add/remove customized features throughout the entire configuration.
        - desktop: Devices configured for the best performance
        - server: Devices for server infrastructure
        - vm: Virtual machines
    '';

    cpu = {
      vendor = defaultOpts.mkEnumFirstDefault [null "intel" "intel-vm"] ''
        The manufacturer of the primary cpu. Will enable specific ucode services and supplies the required kernel modules.
      '';

      hasIntegratedGraphics = defaultOpts.mkBool true "Whether the cpu has integrated graphics or not.";
    };

    gpu = defaultOpts.mkEnumFirstDefault [null "nvidia"] ''
      The manufacturer of the primary GPU.
    '';
  };
}
