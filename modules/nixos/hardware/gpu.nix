{lib, ...}:
with lib.wb; {
  options.wb.hardware.gpu = {
    vendor = defaultOpts.mkEnumFirstDefault ["none" "nvidia"] "The gpu vendor.";
  };
}
