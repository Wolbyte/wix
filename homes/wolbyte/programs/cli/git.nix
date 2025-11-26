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

    package = pkgs.gitFull;

    signing = {
      signByDefault = true;

      key = "0AFE0739FF35365A17725F3441332534F8740D00"; # 41332534F8740D00
    };

    settings = {
      user = {
        name = "wolbyte";

        email = "wolbyte@gmail.com";
      };

      init.defaultBranch = "main";

      url = {
        "https://github.com/".insteadOf = "gh:";
        "git@github.com:".insteadOf = "ssh+gh:";
        "git@github.com:wolbyte/".insteadOf = "gh:/";
      };
    };
  };
}
