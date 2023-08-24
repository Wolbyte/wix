{
  programs.nixvim = {
    plugins.clangd-extensions = {
      enable = true;
      enableOffsetEncodingWorkaround = true;

      memoryUsage.border = "rounded";
      symbolInfo.border = "rounded";
    };
  };
}
