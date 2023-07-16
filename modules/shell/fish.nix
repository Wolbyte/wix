{
  config,
  lib,
  ...
}:
with lib;
with lib.wb; let
  cfg = config.wb.shell.fish;
in {
  options.wb.shell.fish = {
    enable = mkEnableOption "fish";

    vimBindings = defaultOpts.mkBool false "Whether to use fish vim bindings.";

    greeting = defaultOpts.mkStr "" "Fish greeting message.";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      hm.programs.fish = {
        enable = true;

        shellAbbrs = {
          ls = "exa";

          n = "nix";
          ns = "nix shell";
          snr = "sudo nixos-rebuild --flake .";
          snrs = "sudo nixos-rebuild --flake . switch";
          hms = "home-manager switch --flake .";
        };

        functions = {
          fish_greeting = cfg.greeting;
        };
      };
    }

    (mkIf cfg.vimBindings {
      hm.programs.fish.interactiveShellInit = ''
        fish_vi_key_bindings
        set fish_cursor_default     block       blink
        set fish_cursor_insert      line        blink
        set fish_cursor_replace_one underscore  blink
        set fish_cursor_visual      block
      '';
    })
  ]);
}
