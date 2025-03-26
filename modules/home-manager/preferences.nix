{ lib, config, ... }:
with lib;
let
  cfg = config.wix.userPreferences;
in
{
  options.wix.userPreferences = {
    enable = wix.defaultOpts.mkBool false "Enables a set of preferences and customizations for the user.";

    defaultPrograms = {
      browser = wix.defaultOpts.mkEnumFirstDefault [ "firefox" ] "Default browser";

      editor = wix.defaultOpts.mkEnumFirstDefault [ "nvim" ] "Default editor";

      terminalEmulator = wix.defaultOpts.mkEnumFirstDefault [ "kitty" ] " Default terminal emulator";
    };
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      BROWSER = cfg.defaultPrograms.browser;

      EDITOR = cfg.defaultPrograms.editor;
    };
  };
}
