{
  pkgs,
  lib,
  ...
}:
with lib; {
  imports = [./locale.nix];

  config = {
    environment = {
      defaultPackages = mkForce [];

      variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        PAGER = "less -FR";
      };

      systemPackages = with pkgs; [
        git
        curl
        wget
        lshw
      ];
    };
  };
}
