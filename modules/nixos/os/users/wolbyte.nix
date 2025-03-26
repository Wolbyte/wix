{ pkgs, config, ... }:
let
  mkIfGroupsExist =
    groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{

  programs.zsh.enable = true;

  users.extraUsers.wolbyte = {
    isNormalUser = true;

    uid = 1001;

    shell = pkgs.zsh;

    extraGroups =
      [
        "audio"
        "video"
        "storage"
        "wheel"
        "systemd-journal"
      ]
      ++ mkIfGroupsExist [
        "network"
        "networkmanager"
        "mysql"
        "docker"
      ];

    initialPassword = "changeme";
  };
}
