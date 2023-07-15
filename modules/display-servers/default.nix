{lib, ...}:
with lib.wb; {
  options.wb.displayServer = defaultOpts.mkEnumFirstDefault ["none" "wayland"] "The type of display server";
}
