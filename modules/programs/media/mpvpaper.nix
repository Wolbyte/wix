{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.programs.media.mpvpaper;
in {
  options.wb.programs.media.mpvpaper = {
    enable = mkEnableOption "mpvpaper";

    package = mkPackageOpt "mpvpaper" pkgs.mpvpaper;

    nvidiaPatch = defaultOpts.mkBool (config.wb.hardware.gpu.vendor == "nvidia") "Whether to patch mpvpaper to make nvidia work.";
  };

  config = mkIf cfg.enable {
    user.packages =
      if !cfg.nvidiaPatch
      then [cfg.package]
      else [
        (cfg.package.overrideAttrs (old: {
          patches =
            (old.patches or [])
            ++ [
              ../../../overlays/mpvpaper.patch
            ];
        }))
      ];
  };
}
