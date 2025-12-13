{
  lib,
  config,
  osConfig,
  ...
}:
with lib;
let
  inherit (osConfig.wix) host;
in
mkMerge [
  {
    # General
    "general.autoScroll" = true; # enable middle-click scroll

    # ~/Downloads < ~/downloads
    "browser.download.dir" = "${config.home.homeDirectory}/downloads";

    # Disable the default password manager
    "signon.rememberSignons" = false;

    # Disable Activity Stream, new tab tile ads & preload
    "browser.newtabpage.activity-stream.enabled" = false;
    "browser.newtabpage.activity-stream.telemetry" = false;
    "browser.newtabpage.enhanced" = false;
    "browser.newtabpage.introShown" = true;
    "browser.newtab.preload" = false;
    "browser.newtabpage.directory.ping" = "";
    "browser.newtabpage.directory.source" = "data:text/plain,{}";

    # Address bar
    "browser.urlbar.trimURLs" = false;
    "browser.urlbar.suggest.searches" = false;
    "browser.urlbar.shortcuts.bookmarks" = false;
    "browser.urlbar.shortcuts.history" = false;
    "browser.urlbar.shortcuts.tabs" = false;
    "browser.urlbar.showSearchSuggestionsFirst" = false;
    "browser.urlbar.speculativeConnect.enabled" = false;

    # Disable some annoying features
    "browser.translations.automaticallyPopup" = false;
    "browser.aboutConfig.showWarning" = false;
    "browser.aboutwelcome.enable" = false;
    "browser.disableResetPrompt" = true; # Disable the "Looks like you haven't started firefox in a while" prompt
    "browser.onboarding.enabled" = false;

    # Enhaced tracking protection
    "browser.contentblocking.category" = "strict";

    # Disable Form autofill
    # https://wiki.mozilla.org/Firefox/Features/Form_Autofill
    "browser.formfill.enable" = false;
    "extensions.formautofill.addresses.enabled" = false;
    "extensions.formautofill.available" = "off";
    "extensions.formautofill.creditCards.available" = false;
    "extensions.formautofill.creditCards.enabled" = false;
    "extensions.formautofill.heuristics.enabled" = false;

    # Setup DoH
    "network.trr.uri" = "https://svaznt8028.cloudflare-gateway.com/dns-query";
  }

  # Nvidia hardware acceleration (https://github.com/elFarto/nvidia-vaapi-driver/#firefox)
  (mkIf (hasPrefix "nvidia" host.gpu.vendor) {
    "media.ffmpeg.vaapi.enabled" = true;
    "media.rdd-ffmpeg.enabled" = true;
    "gfx.x11-egl.force-enabled" = true;
    "widget.dmabuf.force-enabled" = true;
  })
]
