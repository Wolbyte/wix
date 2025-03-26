{
  imports = [
    ./display
    ./environment
    ./hardware
    ./host
    ./media
    ./nix
    ./os
    ./profiles
  ];

  config = {
    programs.hyprland.enable = true;
  };
}
