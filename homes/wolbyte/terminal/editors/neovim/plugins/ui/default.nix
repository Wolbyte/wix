{pkgs, ...}: {
  imports = [
    ./alpha.nix
    ./bufferline.nix
    ./indent-blankline.nix
    ./lualine.nix
    ./noice.nix
    ./notify.nix
  ];

  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [dressing-nvim];

    extraConfigLua = ''
      require("dressing").setup()
    '';
  };
}
