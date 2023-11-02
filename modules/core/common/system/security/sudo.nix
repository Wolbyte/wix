{
  pkgs,
  lib,
  ...
}:
with lib; {
  security = {
    sudo-rs.enable = mkForce false;

    sudo = {
      enable = true;

      wheelNeedsPassword = false;

      execWheelOnly = true;

      extraConfig = ''
        Defaults lecture = never # rollback results in sudo lectures after each reboot
        Defaults pwfeedback
        Defaults env_keep += "EDITOR PATH"
      '';

      extraRules = [
        {
          groups = ["sudo" "wheel"];
          commands = [
            {
              command = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
              options = ["NOPASSWD"];
            }
          ];
        }
      ];
    };
  };
}
