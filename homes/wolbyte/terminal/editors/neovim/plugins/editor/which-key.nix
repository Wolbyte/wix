{
  programs.nixvim = {
    plugins.which-key = {
      enable = true;

      registrations = {
        "<leader>d" = "Debug";
        "<leader>b" = "Buffers";
        "<leader>f" = "Find";
        "<leader>g" = "Git";
        "<leader>gd" = "Diffview";
        "<leader>t" = "Terminal";
      };

      icons = {
        separator = "";
        group = "+";
      };

      window.border = "rounded";
    };
  };
}
