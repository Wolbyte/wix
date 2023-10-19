{
  pkgs,
  config,
  ...
}: let
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDAKu7dGkkfVOeZ3+ySlaYWmmMILXnYyzAbqmFyrZd/B wolbyte"
  ];

  mkIfGroupsExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  boot.initrd.network.ssh.authorizedKeys = keys;

  programs.fish.enable = true;

  users.users.wolbyte = {
    isNormalUser = true;

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

    uid = 1001;
    shell = pkgs.fish;
    initialPassword = "changeme";
    openssh.authorizedKeys.keys = keys;
  };
}
