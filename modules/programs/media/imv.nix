{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.programs.media.imv;
  colorscheme = config.colorScheme;
in {
  options.wb.programs.media.imv = {
    enable = mkEnableOption "imv";

    package = mkPackageOpt "imv" pkgs.imv;
  };

  config = mkIf cfg.enable {
    hm.programs.imv = {
      enable = true;
      inherit (cfg) package;

      settings = {
        options = {
          background = "${colorscheme.colors.base00}";
          overlay_text_color = "${colorscheme.colors.base05}";
          overlay_background_color = "${colorscheme.colors.base01}";
        };
      };
    };
  };
}
