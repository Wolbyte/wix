{lib, ...}:
with lib.wb; {
  options.wb.displayServer = defaultOpts.mkEnumFirstDefault ["none" "wayland" "x11"] "The type of display server";
}
