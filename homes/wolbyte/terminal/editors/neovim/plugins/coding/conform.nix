{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;

      formatOnSave = {
        lspFallback = true;
        timeoutMs = 3000;
      };
    };
  };
}
