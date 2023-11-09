{lib, ...}:
with lib; {
  programs.fish = {
    enable = true;

    functions = {
      fish_greeting = "";
    };
  };
}
