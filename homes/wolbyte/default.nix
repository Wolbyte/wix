{ lib, ... }:
with lib;
{
  imports = [
    ../../modules/home-manager

    ./desktop-environments
    ./packages
    ./programs
    ./services
    ./theme
    ./tools
  ];

  config = {
    wix = {
      userPreferences = {
        enable = true;

        defaultPrograms = {
          browser = "firefox";

          editor = "nvim";
        };
      };
    };

    home = rec {
      username = "wolbyte";

      homeDirectory = "/home/${username}";

      stateVersion = mkDefault "24.11";
    };

    programs.home-manager.enable = true;
  };
}
