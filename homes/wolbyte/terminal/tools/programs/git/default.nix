{
  osConfig,
  pkgs,
  ...
}: let
  cfg = osConfig.wb.programs.git;
in {
  programs = {
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };

    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "wolbyte";
      userEmail = "wolbyte@gmail.com";

      signing = {
        key = cfg.signingKey;
        signByDefault = true;
      };

      extraConfig = {
        init.defaultBranch = "main";

        url = {
          "https://github.com/".insteadOf = "gh:";
          "git@github.com:".insteadOf = "ssh+gh:";
          "git@github.com:wolbyte/".insteadOf = "gh:/";
        };
      };
    };
  };
}
