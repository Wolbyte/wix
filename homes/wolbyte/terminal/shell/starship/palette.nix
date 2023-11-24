{config, ...}: let
  inherit (config.colorscheme) colors;
in {
  red = "#${colors.base08}";
  black = "#${colors.base00}";
  blue = "#${colors.base0D}";
  cyan = "#${colors.base0C}";
  green = "#${colors.base0B}";
  magenta = "#${colors.base0D}";
  white = "#${colors.base00}";
  yellow = "#${colors.base0A}";
  purple = "#${colors.base0D}";
  gold = "#${colors.base09}";

  inherit
    (colors)
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
