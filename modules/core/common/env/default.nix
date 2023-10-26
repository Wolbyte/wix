{lib, ...}:
with lib;
with lib.wb; {
  options.wb.env = {
    desktopEnv = defaultOpts.mkEnumFirstDefault ["Hyprland"] "The desktop environment to use.";

    isWayland = defaultOpts.mkBool true "Whether to enable wayland specefic features (such as wms, services, etc).";
  };
}
