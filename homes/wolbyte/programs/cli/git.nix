{
  pkgs,
  ...
}:
{

  programs.gh = {
    enable = true;

    gitCredentialHelper.enable = true;

    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };

  programs.git = {
    enable = true;

    package = pkgs.gitAndTools.gitFull;

    userName = "wolbyte";

    userEmail = "wolbyte@gmail.com";

    signing = {
      signByDefault = true;

      key = "0AFE0739FF35365A17725F3441332534F8740D00"; # 41332534F8740D00
    };

    extraConfig = {
      init.defaultBranch = "main";

      url = {
        "https://github.com/".insteadOf = "gh:";
        "git@github.com:".insteadOf = "ssh+gh:";
        "git@github.com:wolbyte".insteadOf = "gh:/";
      };
    };
  };
}
