{
  programs.nixvim = {
    plugins.spider = {
      enable = true;

      skipInsignificantPunctuation = false;

      keymaps = {
        motions = {
          w = "w";
          e = "e";
          b = "b";
          ge = "ge";
        };
      };
    };
  };
}
