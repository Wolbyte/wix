{
  pkgs,
  lib,
  ...
}:
with lib;
{
  config = {
    environment = {
      defaultPackages = mkForce [ ];

      variables = {
        EDITOR = "nvim";

        VISUAL = "nvim";

        PAGER = "less -FR";
      };

      systemPackages = with pkgs; [
        neovim
        git
        curl
        lshw
        efibootmgr
      ];
    };

    i18n.defaultLocale = "en_US.UTF-8";

    time = {
      timeZone = "Asia/Tehran";

      hardwareClockInLocalTime = false;
    };
  };
}
