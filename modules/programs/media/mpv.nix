{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.programs.media.mpv;
  colorscheme = config.colorScheme;
in {
  options.wb.programs.media.mpv = {
    enable = mkEnableOption "mpv";

    package = mkPackageOpt "mpv" pkgs.mpv;

    defaultProfiles = mkOpt (types.listOf types.str) [] "MPV profiles.";

    hardwareAcceleration = defaultOpts.mkBool false "Whether to enable hardware acceleration related options for mpv.";

    scripts = mkOpt (types.listOf types.package) [] "List of additional mpv scripts to install.";
  };

  config = mkIf cfg.enable {
    user.packages = [pkgs.mpvc];

    hm.programs.mpv = mkMerge [
      {
        enable = true;
        inherit (cfg) package;
        inherit (cfg) defaultProfiles;

        config = {
          osc = "no";
          osd-bar = "no";
          border = "no";
          slang = "per,fa,eng,en";
          sub-auto = "fuzzy";
        };

        scriptOpts = {
          uosc = {
            background = "${colorscheme.colors.base00}";
            background_text = "${colorscheme.colors.base05}";
            foreground = "${colorscheme.colors.base05}";
            foreground_text = "${colorscheme.colors.base00}";
          };
        };

        scripts = with pkgs.mpvScripts;
          [
            mpris
            thumbfast
            uosc
          ]
          ++ cfg.scripts;
      }

      (mkIf cfg.hardwareAcceleration {
        config = {
          hwdec = "auto";
          scale = "ewa_lanczossharp";
          cscale = "ewa_lanczossharp";
          video-sync = "display-resample";
          tscale = "oversample";
        };
      })
    ];
  };
}
