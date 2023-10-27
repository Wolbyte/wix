{lib, ...}:
with lib; {
  config = {
    systemd.user.startServices = mkDefault "sd-switch";

    home = rec {
      username = "wolbyte";
      homeDirectory = "/home/${username}";

      stateVersion = mkDefault "23.05";
    };

    programs.home-manager.enable = true;
  };
}
