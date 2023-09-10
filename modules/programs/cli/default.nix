{pkgs, ...}: {
  user.packages = with pkgs; [
    bc
    bottom
    exa
    fd
    jq
    ripgrep
    socat
  ];
}
