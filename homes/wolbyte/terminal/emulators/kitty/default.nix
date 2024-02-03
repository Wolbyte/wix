{
  config,
  lib,
  osConfig,
  ...
}:
with lib; let
  inherit (osConfig.wb) device;
  acceptedTypes = ["desktop" "hybrid"];

  isAccepted = builtins.elem device.profile acceptedTypes;
in {
  config = mkIf isAccepted {
    programs.kitty = {
      enable = true;
      settings = import ./settings.nix {colors = config.colorscheme.palette;};
      keybindings = import ./keybinds.nix {};
    };
  };
}
