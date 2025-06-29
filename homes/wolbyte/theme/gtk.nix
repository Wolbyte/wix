{
  pkgs,
  ...
}:
{
  gtk = {
    enable = true;

    iconTheme = {
      package = pkgs.rose-pine-icon-theme;

      name = "rose-pine";
    };

    theme = {
      package = pkgs.wix.magnetic-rose-pine-gtk.override {
        accent = [ "purple" ];
      };

      name = "Rose-Pine-GTK-Purple-Dark";
    };
  };
}
