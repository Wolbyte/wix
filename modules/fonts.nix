{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.fonts;
in {
  options.wb.fonts = {
    enable = mkEnableOption "font profiles";

    monospace = defaultOpts.mkFont "monospace" "FiraCode Nerd Font" (pkgs.nerdfonts.override {fonts = ["FiraCode"];});

    regular = defaultOpts.mkFont "regular" "Fira Sans" pkgs.fira;

    emoji = defaultOpts.mkFont "emoji" "Noto Color Emoji" pkgs.noto-fonts-emoji;

    extraFonts = mkOpt (types.attrsOf (types.submodule {
      options = {
        family = defaultOpts.mkStr "" "Family name for the font.";

        package = mkPackageOpt "font" null;

        type = defaultOpts.mkEnumFirstDefault ["regular" "monospace" "emoji"] "Type of the font.";
      };
    })) {} "Extra fonts to install.";
  };

  config = mkIf cfg.enable {
    fonts = {
      fontconfig.enable = true;

      packages =
        [
          cfg.monospace.package
          cfg.regular.package
          cfg.emoji.package
        ]
        ++ (mapAttrsToList (_: fontOpts: fontOpts.package) cfg.extraFonts);
    };
  };
}
