{
  programs.nixvim = {
    plugins = {
      ts-context-commentstring.enable = true;

      spider = {
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

      leap.enable = true;
    };
  };
}
