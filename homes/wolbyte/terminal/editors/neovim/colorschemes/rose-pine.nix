{
  config,
  lib,
  ...
}: let
  bufferlineEnabled = config.programs.nixvim.plugins.bufferline.enable;
in {
  programs.nixvim = {
    colorschemes.rose-pine = {
      enable = true;

      settings = {
        enable = {
          italics = true;
          transparency = true;
        };

        highlight_groups = {
          NormalFloat = {fg = "none";};
          NeoTreeDirectoryIcon = {fg = "subtle";};
          NeoTreeDirectoryName = {fg = "foam";};
          NeoTreeNormal = {fg = "text";};
          NeoTreeRootName = {fg = "iris";};
          NeoTreeTabInactive = {
            bg = "none";
            fg = "muted";
          };
          NeoTreeTabSeparatorActive = {
            bg = "none";
            fg = "subtle";
          };
          NeoTreeTabSeparatorInactive = {
            bg = "none";
            fg = "subtle";
          };
        };
      };
    };

    plugins.bufferline = lib.mkIf bufferlineEnabled {
      extraOptions.highlights.__raw = "require('rose-pine.plugins.bufferline')";
    };
  };
}
