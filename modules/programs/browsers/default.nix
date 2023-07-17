{
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.programs.browsers;
in {
  options.wb.programs.browsers = {
    default = defaultNullOpts.mkStr "null" "Default browser to use.";
  };

  config = mkIf (cfg.default != null) {
    env.BROWSER = cfg.default;
  };
}
