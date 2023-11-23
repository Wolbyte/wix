{
  config = {
    services.xserver = {
      layout = "us,ir";
      xkbOptions = "grp:win_space_toggle";

      xrandrHeads = [
        {
          output = "HDMI-0";
          primary = true;
        }
      ];
    };
  };
}
