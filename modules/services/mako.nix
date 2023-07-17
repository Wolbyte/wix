{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.services.mako;
  colorscheme = config.colorScheme;
in {
  options.wb.services.mako = {
    enable = mkEnableOption "Mako notification service.";
  };

  config = mkIf cfg.enable {
    user.packages = [pkgs.libnotify];

    hm.services.mako = {
      enable = true;

      borderRadius = 10;
      defaultTimeout = 5000;
      font = "${config.wb.fonts.regular.family} 12";
      height = 400;
      maxIconSize = 128;
      width = 350;

      # https://github.com/stacyharper/base16-mako
      backgroundColor = "#${colorscheme.colors.base00}";
      textColor = "#${colorscheme.colors.base05}";
      borderColor = "#${colorscheme.colors.base0D}";

      extraConfig = ''
        [urgency=low]
        background-color=#${colorscheme.colors.base00}
        text-color=#${colorscheme.colors.base0A}
        border-color=#${colorscheme.colors.base0D}

        [urgency=high]
        default-timeout=0
        background-color=#${colorscheme.colors.base00}
        text-color=#${colorscheme.colors.base08}
        border-color=#${colorscheme.colors.base0D}

        [app-name=Spotify]
        text-alignment=center
      '';
    };
  };
}
