{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.displayServers.wayland;
in {
  options.wb.displayServers.wayland = {
    enable = mkEnableOption "wayland";

    ozoneLayer = defaultOpts.mkBool false "Whether to enable ozone layer for electron apps.";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      wb.displayServer = "wayland";

      wb.services.mako.enable = true;

      env = {
        XDG_SESSION_TYPE = "wayland";
        EGL_PLATFORM = "wayland,x11";

        SDL_VIDEODRIVER = "wayland";
        GDK_BACKEND = "wayland,x11";
        CLUTTER_BACKEND = "wayland";

        LIBSEAT_BACKEND = "logind";

        WLR_BACKEND = "vulkan";
        WLR_RENDERER = "vulkan";
      };

      user.packages = with pkgs; [
        cliphist
        grim
        slurp
        swaybg
        wl-clipboard
      ];
    }

    (mkIf cfg.ozoneLayer {
      env.NIXOS_OZONE_WL = "1";
    })
  ]);
}
