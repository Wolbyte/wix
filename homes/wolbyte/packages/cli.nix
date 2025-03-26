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
    timg
    unzip
  ];

  waylandPackages = with pkgs; [
    grim
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
