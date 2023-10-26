{lib, ...}:
with lib;
with lib.wb; {
  options.wb.device = {
    hasBluetooth = defaultOpts.mkBool true "Whether the device supports bluetooth or not.";

    hasSound = defaultOpts.mkBool true "Whether the device supports sound or not.";

    hasTPM = defaultOpts.mkBool true "Whether the device supports TPM or not.";
  };
}
