{lib, ...}:
with lib;
with lib.wb; {
  options.wb.env = {
    desktopEnv = defaultOpts.mkEnumFirstDefault ["Hyprland"] "The desktop environment to use.";

    isWayland = defaultOpts.mkBool true "Enables wayland specefic features such as wms, services, etc.";

    enableHomeManager = defaultOpts.mkBool true "Whether to use home-manager or not.";
  };
}
