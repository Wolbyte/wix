{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.dev.rust;
in {
  options.wb.dev.rust = {
    enable = mkEnableOption "rust";

    rustupPackage = mkPackageOpt "rustup" pkgs.rustup;
  };

  config = mkIf cfg.enable {
    user.packages = [cfg.rustupPackage pkgs.clang];

    env = {
      RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
      CARGO_HOME = "$XDG_DATA_HOME/cargo";
      PATH = ["$CARGO_HOME/bin"];
    };
  };
}
