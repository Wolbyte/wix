{
  config,
  lib,
  ...
}:
with lib; let
  inherit (config.wb) device;
  acceptedTypes = ["desktop" "hybrid"];
in {
  config = mkIf (builtins.elem device.profile acceptedTypes) {
    environment.variables = {
      BROWSER = "firefox";
    };
  };
}
