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
    networkmanagerapplet
    openvpn
    pamixer
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
    swaybg
    wl-clipboard
    wlogout
    wtype
  ];
in
{
  home.packages = mkMerge [
    sharedPacakges
    (optionals (host.displayServer == "wayland") waylandPackages)
  ];
}
