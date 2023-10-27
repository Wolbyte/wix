{lib, ...}:
with lib;
with lib.wb; {
  options.wb = {
    programs.default = {
      terminal = defaultOpts.mkEnumFirstDefault ["kitty"] "The default terminal emulator.";

      fileManager = defaultOpts.mkEnumFirstDefault ["dolphin"] "The default file manager.";

      browser = defaultOpts.mkEnumFirstDefault ["firefox"] "The default browser.";

      editor = defaultOpts.mkEnumFirstDefault ["neovim"] "The default editor.";

      launcher = defaultOpts.mkEnumFirstDefault ["rofi"] "The default launcher.";
    };
  };
}
