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
    user.packages = with pkgs.gitAndTools; [
      diff-so-fancy
      gh
      (mkIf config.wb.programs.cli.gnupg.enable
        git-crypt)
    ];
    hm.programs.git = {
      enable = true;

      package = pkgs.gitAndTools.gitFull;

      userName = config.user.name;
      userEmail =
        if config.user.name == "wolbyte"
        then "wolbyte@gmail.com"
        else "";

      extraConfig = {
        commit.gpgSign = true;
        credential = {
          "https://github.com".helper = "!gh auth git-credential";
        };
        init.defaultBranch = "main";
        url = {
          "https://github.com/".insteadOf = "gh:";
          "git@github.com:".insteadOf = "ssh+gh:";
          "git@github.com:wolbyte/".insteadOf = "gh:/";
        };
        user.signing.key = "0AFE0739FF35365A17725F3441332534F8740D00";
      };
    };
  };
}
