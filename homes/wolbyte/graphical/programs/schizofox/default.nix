{
  osConfig,
  config,
  inputs,
  lib,
  ...
}:
with lib; let
  inherit (osConfig.wb) device;
  acceptedTypes = ["desktop" "hybrid"];
  inherit (config.colorscheme) palette;
in {
  imports = [inputs.schizofox.homeManagerModule];

  config = mkIf (builtins.elem device.profile acceptedTypes) {
    programs.schizofox = {
      enable = true;

      theme = {
        font = "Lexend";
        colors = {
          background-darker = "${palette.base00}";
          background = "${palette.base01}";
          foreground = "${palette.base05}";
        };
      };

      extensions = {
        simplefox.enable = false;
        darkreader.enable = true;

        defaultExtensions = {};
        extraExtensions = {
          # Ublock adblocker
          "uBlock0@raymondhill.net".install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          # Return youtube dislikes
          "{762f9885-5a13-4abd-9c77-433dcd38b8fd}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
          # DontFuckWithPaste
          "DontFuckWithPaste@raim.ist".install_url = "https://addons.mozilla.org/firefox/downloads/latest/don-t-fuck-with-paste/latest.xpi";
          # Single file: save an entire page into a single html file
          "{531906d3-e22f-4a6c-a102-8057b88a1a63}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/single-file/latest.xpi";
          # Clear urls
          "{74145f27-f039-47ce-a470-a662b129930a}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
          # Skip Redirect
          "skipredirect@sblask".install_url = "https://addons.mozilla.org/firefox/downloads/latest/skip-redirect/latest.xpi";
          # Smart referer
          "smart-referer@meh.paranoid.pk".install_url = "https://addons.mozilla.org/firefox/downloads/latest/smart-referer/latest.xpi";
          # Localcdn
          "{b86e4813-687a-43e6-ab65-0bde4ab75758}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/localcdn-fork-of-decentraleyes/latest.xpi";
          # Vimium C
          "vimium-c@gdh1995.cn".install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
          # Setupvpn
          "@setupvpncom".install_url = "https://addons.mozilla.org/firefox/downloads/latest/setupvpn/latest.xpi";
          # Bitwarden
          "{446900e4-71c2-419f-a6a7-df9c091e268b}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          # Refined github
          "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/refined-github-/latest.xpi";
          # Sponsorblock
          "sponsorBlocker@ajay.app".install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
        };
      };
    };
  };
}
