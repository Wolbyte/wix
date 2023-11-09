{
  programs.nixvim = {
    plugins.alpha = {
      enable = true;

      layout = [
        {
          type = "padding";
          val = 10;
        }
        {
          opts = {
            hl = "Type";
            position = "center";
          };
          type = "text";
          val = [
            " ▄▄▌ ▐ ▄▌      ▄▄▌  ▄▄▄▄·  ▄· ▄▌▄▄▄▄▄▄▄▄ . "
            " ██· █▌▐█▪     ██•  ▐█ ▀█▪▐█▪██▌•██  ▀▄.▀· "
            " ██▪▐█▐▐▌ ▄█▀▄ ██▪  ▐█▀▀█▄▐█▌▐█▪ ▐█.▪▐▀▀▪▄ "
            " ▐█▌██▐█▌▐█▌.▐▌▐█▌▐▌██▄▪▐█ ▐█▀·. ▐█▌·▐█▄▄▌ "
            "  ▀▀▀▀ ▀▪ ▀█▄▀▪.▀▀▀ ·▀▀▀▀   ▀ •  ▀▀▀  ▀▀▀  "
          ];
        }
        {
          type = "padding";
          val = 2;
        }
        {
          type = "group";
          val = [
            {
              command = "<CMD>ene <CR>";
              desc = " New file";
              shortcut = "e";
            }
            {
              command = ":qa<CR>";
              desc = "󰗼 Quit Neovim";
              shortcut = "SPC q";
            }
          ];
        }
      ];
    };
  };
}
