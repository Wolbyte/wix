{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.programs.cli.git;
in {
  options.wb.programs.cli.git = {
    enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
    hm.programs.git = {
      enable = true;

      package = pkgs.gitAndTools.gitFull;

      userName = config.user.name;
      userEmail = "";

      extraConfig = {
        init.defaultBranch = "main";
        user.signing.key = "CDCD5522EBC6A1A1BC728E9DE7D6F4AEA530135D";
        commit.gpgSign = true;
        gpg.program = "${config.programs.gnupg.package}/bin/gpg2";
      };
    };
  };
}
