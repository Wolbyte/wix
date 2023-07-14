{
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.services.ssh;
in {
  options.wb.services.ssh = {
    enable = mkEnableOption "ssh";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
      };
    };

    user.openssh.authorizedKeys.keys =
      if config.user.name == "wolbyte"
      then [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDAKu7dGkkfVOeZ3+ySlaYWmmMILXnYyzAbqmFyrZd/B wolbyte"
      ]
      else [];
  };
}
