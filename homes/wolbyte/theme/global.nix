{osConfig, ...}: let
  cfg = osConfig.wb.theme;
in {
  home = {
    pointerCursor = {
      inherit (cfg.cursor) name package size;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
