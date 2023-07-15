{
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
      icons = {
        separator = "";
        group = "";
      };

      window.border = "rounded";
    };
  };
}
