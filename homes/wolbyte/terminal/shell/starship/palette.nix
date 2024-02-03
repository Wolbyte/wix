{config, ...}: let
  inherit (config.colorscheme) palette;
in {
  red = "#${palette.base08}";
  black = "#${palette.base00}";
  blue = "#${palette.base0D}";
  cyan = "#${palette.base0C}";
  green = "#${palette.base0B}";
  magenta = "#${palette.base0D}";
  white = "#${palette.base00}";
  yellow = "#${palette.base0A}";
  purple = "#${palette.base0D}";
  gold = "#${palette.base09}";

  inherit
    (palette)
    base00
    base01
    base02
    base03
    base04
    base05
    base07
    base08
    base09
    base0A
    base0B
    base0C
    base0D
    base0E
    base0F
    ;
}
