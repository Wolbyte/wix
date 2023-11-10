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
      settings = import ./settings.nix {inherit (config.colorscheme) colors;};
      keybindings = import ./keybinds.nix {};
    };
  };
}
