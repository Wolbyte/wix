{ pkgs, ... }:
{
  programs.bat = {
    enable = true;

    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
    ];

    config = {
      pager = "less -FR";
      tabs = "2";
    };
  };
}
