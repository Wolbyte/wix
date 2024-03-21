{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      lsp.enabledServers = [
        {
          name = "neocmake";
          extraOptions = {};
        }
      ];
    };

    extraPlugins = with pkgs.vimPlugins; [cmake-tools-nvim];
    extraPackages = with pkgs; [neocmakelsp];
  };
}
