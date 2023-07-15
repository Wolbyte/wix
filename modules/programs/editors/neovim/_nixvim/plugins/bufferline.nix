{
  programs.nixvim = {
    plugins.bufferline = {
      enable = true;

      showCloseIcon = false;
      showBufferCloseIcons = false;

      maxNameLength = 14;
      maxPrefixLength = 13;

      offsets = [
        {
          filetype = "neo-tree";
          padding = 0;
          text = "File Explorer";
          separator = true;
        }
      ];

      tabSize = 20;

      extraOptions = {
        separator_style = ["|" "|"];
        indicator.style = "none";
      };
    };

    maps.normal = {
      "<A-l>" = "<cmd>BufferLineCycleNext<CR>";
      "<A-h>" = "<cmd>BufferLineCyclePrev<CR>";
      "<A-s-l>" = "<cmd>BufferLineMoveNext<CR>";
      "<A-s-h>" = "<cmd>BufferLineMovePrev<CR>";
    };
  };
}
