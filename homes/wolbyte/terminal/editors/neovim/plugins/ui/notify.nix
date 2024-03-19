{
  programs.nixvim = {
    plugins.notify = {
      enable = true;
      stages = "fade";
      backgroundColour = "#000000";
    };
  };
}
