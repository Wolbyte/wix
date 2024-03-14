{
  config,
  lib,
  ...
}: let
  cmpEnabled = config.programs.nixvim.plugins.cmp.enable;
in {
  programs.nixvim = {
    plugins.nvim-autopairs = {
      enable = true;
      checkTs = true;
    };

    extraConfigLua = lib.mkIf cmpEnabled ''
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    '';
  };
}
