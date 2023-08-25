{
  programs.nixvim = {
    plugins = {
      comment-nvim = {
        enable = true;
      };

      spider = {
        enable = true;

        skipInsignificantPunctuation = true;

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
