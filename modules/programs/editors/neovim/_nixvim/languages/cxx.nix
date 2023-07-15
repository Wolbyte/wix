{
  programs.nixvim = {
    plugins.clangd-extensions = {
      enable = true;
      enableOffsetEncodingWorkaround = true;

      extensions = {
        memoryUsage.border = "rounded";
        symbolInfo.border = "rounded";
      };
    };
  };
}
