{
  config = {
    services.xserver = {
      xkb = {
        layout = "us,ir";
        options = "grp:win_space_toggle";
      };

      xrandrHeads = [
        {
          output = "HDMI-0";
          primary = true;
        }
      ];
    };
  };
}
