{
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib;
let
  inherit (osConfig.wix) host;

  sharedPacakges = with pkgs; [
    dconf
    fd
    ffmpeg-full
    file
    fzf
    jq
    openvpn
    playerctl
    ripgrep
    rsync
    socat
    timg
    unzip
  ];

  waylandPackages = with pkgs; [
    grim
    grimblast
    slurp
    wl-clipboard
    wtype
  ];
in
{
  home.packages = mkMerge [
    sharedPacakges
    (optionals (host.displayServer == "wayland") waylandPackages)
  ];
}
