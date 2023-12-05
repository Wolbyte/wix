{
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib; let
  inherit (osConfig.wb) programs;
in {
  config = mkIf programs.cli.enable {
    home.packages = with pkgs; [
      catimg
      dconf
      fd
      file
      fzf
      jq
      openvpn
      ripgrep
      rsync
      socat
      unzip
    ];
  };
}
