{ config, ... }:
let
  mkLock = Value: {
    inherit Value;
    Status = "locked";
  };
in
{
  # ~/Downloads < ~/downloads
  "browser.download.dir" = "${config.home.homeDirectory}/downloads";

  # Disable the default password manager
  "signon.rememberSignons" = mkLock false;

  # Disable Activity Stream, new tab tile ads & preload
  "browser.newtabpage.activity-stream.enabled" = false;
  "browser.newtabpage.activity-stream.telemetry" = false;
  "browser.newtabpage.enhanced" = false;
  "browser.newtabpage.introShown" = true;
  "browser.newtab.preload" = false;
  "browser.newtabpage.directory.ping" = "";
  "browser.newtabpage.directory.source" = "data:text/plain,{}";

  # Address bar
  "browser.urlbar.trimURLs" = mkLock false;
  "browser.urlbar.suggest.searches" = mkLock false;
  "browser.urlbar.shortcuts.bookmarks" = mkLock false;
  "browser.urlbar.shortcuts.history" = mkLock false;
  "browser.urlbar.shortcuts.tabs" = mkLock false;
  "browser.urlbar.showSearchSuggestionsFirst" = mkLock false;
  "browser.urlbar.speculativeConnect.enabled" = mkLock false;

  # Disable some annoying features
  "browser.translations.automaticallyPopup" = mkLock false;
  "browser.aboutConfig.showWarning" = mkLock false;
  "browser.aboutwelcome.enable" = mkLock false;
  "browser.disableResetPrompt" = mkLock true; # Disable the "Looks like you haven't started firefox in a while" prompt
  "browser.onboarding.enabled" = mkLock false;

  # Enhaced tracking protection
  "browser.contentblocking.category" = "strict";
  "privacy.donottrackheader.enabled" = mkLock true;
  "privacy.donottrackheader.value" = 1;
  "privacy.purge_trackers.enabled" = mkLock true;

  # Disable Form autofill
  # https://wiki.mozilla.org/Firefox/Features/Form_Autofill
  "browser.formfill.enable" = mkLock false;
  "extensions.formautofill.addresses.enabled" = mkLock false;
  "extensions.formautofill.available" = "off";
  "extensions.formautofill.creditCards.available" = mkLock false;
  "extensions.formautofill.creditCards.enabled" = mkLock false;
  "extensions.formautofill.heuristics.enabled" = mkLock false;
}
