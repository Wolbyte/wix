{
  colors,
  mkLiteral,
  ...
}: {
  "*" = {
    "background" = mkLiteral "#${colors.base00}";
    "alt-background" = mkLiteral "#${colors.base02}";
    "foreground" = mkLiteral "#${colors.base05}";
    "border-color" = mkLiteral "#${colors.base0C}";
    "selected" = mkLiteral "#${colors.base0D}";
    "active" = mkLiteral "#${colors.base0A}";
    "urgent" = mkLiteral "#${colors.base08}";
  };

  "window" = {
    enabled = true;
    anchor = mkLiteral "center";
    cursor = mkLiteral "default";
    fullscreen = false;
    location = mkLiteral "center";
    width = mkLiteral "600px";
    x-offset = mkLiteral "0px";
    y-offset = mkLiteral "0px";
    background-color = mkLiteral "@background";
    border = mkLiteral "2px";
    border-color = mkLiteral "@border-color";
    border-radius = mkLiteral "10px";
  };

  "mainbox" = {
    enabled = true;
    children = mkLiteral "[inputbar,listbox,mode-switcher]";
    orientation = mkLiteral "vertical";
    spacing = mkLiteral "0px";
    background-color = mkLiteral "transparent";
  };

  "listbox" = {
    enabled = true;
    children = mkLiteral "[message,listview]";
    orientation = mkLiteral "vertical";
    padding = mkLiteral "10px 10px 10px 15px";
    spacing = mkLiteral "10px";
    background-color = mkLiteral "transparent";
  };

  "inputbar" = {
    enabled = true;
    children = mkLiteral "[prompt,entry]";
    orientation = mkLiteral "horizontal";
    padding = mkLiteral "30px 20px 30px 20px";
    spacing = mkLiteral "10px";
    background-color = mkLiteral "@alt-background";
    text-color = mkLiteral "@foreground";
  };

  "entry" = {
    enabled = true;
    cursor = mkLiteral "text";
    expand = true;
    padding = mkLiteral "12px 15px";
    placeholder = "Search";
    placeholder-color = mkLiteral "inherit";
    width = mkLiteral "300px";
    border-radius = mkLiteral "15px";
    background-color = mkLiteral "@background";
    text-color = mkLiteral "inherit";
  };

  "prompt" = {
    cursor = mkLiteral "pointer";
    font = "Iosevka Nerd Font 13";
    padding = mkLiteral "10px 20px 10px 20px";
    width = mkLiteral "64px";
    border-radius = mkLiteral "15px";
    background-color = mkLiteral "@background";
    text-color = mkLiteral "inherit";
    vertical-align = mkLiteral "0.5";
  };

  "mode-switcher" = {
    enabled = true;
    spacing = mkLiteral "10px";
    padding = mkLiteral "10px 10px 10px 10px";
    background-color = mkLiteral "transparent";
    text-color = mkLiteral "@foreground";
  };

  "button" = {
    cursor = mkLiteral "pointer";
    font = "Iosevka Nerd Font 14";
    padding = mkLiteral "8px 5px 8px 8px";
    width = mkLiteral "48px";
    horizontal-align = mkLiteral "0.5";
    vertical-align = mkLiteral "0.5";
    border-radius = mkLiteral "15px";
    background-color = mkLiteral "@alt-background";
    text-color = mkLiteral "inherit";
  };

  "button selected" = {
    background-color = mkLiteral "@selected";
    text-color = mkLiteral "@background";
  };

  "listview" = {
    enabled = true;
    columns = 2;
    lines = 5;
    cursor = mkLiteral "default";
    cycle = true;
    dynamic = true;
    fixed-height = true;
    fixed-columns = false;
    layout = mkLiteral "vertical";
    scrollbar = false;
    reverse = false;
    spacing = mkLiteral "5px";
    background-color = mkLiteral "transparent";
    text-color = mkLiteral "@foreground";
  };

  "element" = {
    enabled = true;
    cursor = mkLiteral "pointer";
    padding = mkLiteral "7px";
    spacing = mkLiteral "15px";
    border-radius = mkLiteral "100%";
    background-color = mkLiteral "transparent";
    text-color = mkLiteral "@foreground";
  };

  "element normal.normal" = {
    background-color = mkLiteral "inherit";
    text-color = mkLiteral "inherit";
  };
  "element normal.urgent" = {
    background-color = mkLiteral "@urgent";
    text-color = mkLiteral "@background";
  };
  "element normal.active" = {
    background-color = mkLiteral "@background";
    text-color = mkLiteral "@active";
  };
  "element selected.normal" = {
    background-color = mkLiteral "@selected";
    text-color = mkLiteral "@background";
  };
  "element selected.urgent" = {
    background-color = mkLiteral "@urgent";
    text-color = mkLiteral "@background";
  };
  "element selected.active" = {
    background-color = mkLiteral "@urgent";
    text-color = mkLiteral "@active";
  };
  "element-icon" = {
    cursor = mkLiteral "inherit";
    size = mkLiteral "32px";
    background-color = mkLiteral "transparent";
    text-color = mkLiteral "inherit";
  };
  "element-text" = {
    background-color = mkLiteral "transparent";
    text-color = mkLiteral "inherit";
    cursor = mkLiteral "inherit";
    vertical-align = mkLiteral "0.5";
    horizontal-align = mkLiteral "0.0";
  };

  "message" = {background-color = mkLiteral "transparent";};

  "textbox" = {
    horizontal-align = mkLiteral "0.0";
    vertical-align = mkLiteral "0.5";
    padding = mkLiteral "12px";
    border-radius = mkLiteral "100%";
    background-color = mkLiteral "@alt-background";
    text-color = mkLiteral "@foreground";
  };

  "error-message" = {
    padding = mkLiteral "12px";
    border-radius = mkLiteral "20px";
    background-color = mkLiteral "@background";
    text-color = mkLiteral "@foreground";
  };
}
