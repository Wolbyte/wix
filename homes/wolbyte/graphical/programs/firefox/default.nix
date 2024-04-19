{
  pkgs,
  osConfig,
  lib,
  ...
}:
with lib; let
  inherit (osConfig.wb) device;
  acceptedTypes = ["desktop" "hybrid"];

  mkExt = url: {
    install_url = url;
    installation_mode = "force_installed";
  };

  lockFalse = {
    Value = false;
    Status = "locked";
  };

  lockTrue = {
    Value = true;
    Status = "locked";
  };
in {
  config = mkIf (builtins.elem device.profile acceptedTypes) {
    programs.firefox = {
      enable = true;

      policies = {
        # Extensions
        ExtensionSettings = {
          # Ublock Origin
          "uBlock0@raymondhill.net" = mkExt "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          # Return YouTube dislikes
          "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = mkExt "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
          # DontFuckWithPaste
          "DontFuckWithPaste@raim.ist" = mkExt "https://addons.mozilla.org/firefox/downloads/latest/don-t-fuck-with-paste/latest.xpi";
          # Single file: save an entire page into a single html file
          "{531906d3-e22f-4a6c-a102-8057b88a1a63}" = mkExt "https://addons.mozilla.org/firefox/downloads/latest/single-file/latest.xpi";
          # Clear urls
          "{74145f27-f039-47ce-a470-a662b129930a}" = mkExt "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
          # Skip Redirect
          "skipredirect@sblask" = mkExt "https://addons.mozilla.org/firefox/downloads/latest/skip-redirect/latest.xpi";
          # Smart referer
          "smart-referer@meh.paranoid.pk" = mkExt "https://addons.mozilla.org/firefox/downloads/latest/smart-referer/latest.xpi";
          # Localcdn
          "{b86e4813-687a-43e6-ab65-0bde4ab75758}" = mkExt "https://addons.mozilla.org/firefox/downloads/latest/localcdn-fork-of-decentraleyes/latest.xpi";
          # Vimium C
          "vimium-c@gdh1995.cn" = mkExt "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
          # Setupvpn
          "@setupvpncom" = mkExt "https://addons.mozilla.org/firefox/downloads/latest/setupvpn/latest.xpi";
          # Bitwarden
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = mkExt "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          # Refined github
          "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = mkExt "https://addons.mozilla.org/firefox/downloads/latest/refined-github-/latest.xpi";
          # Sponsorblock
          "sponsorBlocker@ajay.app" = mkExt "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          # Darkreader
          "addon@darkreader.org" = mkExt "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
        };

        # Privacy
        DisableFirefoxStudies = true;
        DisableTelemetry = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

        # QoL
        DisablePocket = true;
        DisplayBookmarksToolbar = "newtab";
        DontCheckDefaultBrowser = true;
        OverrideFirstRunPage = "";

        # Preferences
        Preferences = {
          "browser.contentblocking.category" = {
            Value = "strict";
            Status = "locked";
          };
          "extensions.pocket.enabled" = lockFalse;
          "browser.topsites.contile.enabled" = lockFalse;
          "browser.formfill.enable" = lockFalse;
          "browser.search.suggest.enabled" = lockFalse;
          "browser.search.suggest.enabled.private" = lockFalse;
          "browser.urlbar.suggest.searches" = lockFalse;
          "browser.urlbar.showSearchSuggestionsFirst" = lockFalse;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = lockFalse;
          "browser.newtabpage.activity-stream.feeds.snippets" = lockFalse;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lockFalse;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lockFalse;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lockFalse;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lockFalse;
          "browser.newtabpage.activity-stream.showSponsored" = lockFalse;
          "browser.newtabpage.activity-stream.system.showSponsored" = lockFalse;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lockFalse;

          "browser.aboutConfig.showWarning".Value = false;

          "browser.uiCustomization.state".Value = {
            "placements" = {
              "widget-overflow-fixed-list" = [];
              "unified-extensions-area" = ["_531906d3-e22f-4a6c-a102-8057b88a1a63_-browser-action" "skipredirect_sblask-browser-action" "_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action" "smart-referer_meh_paranoid_pk-browser-action" "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action" "_74145f27-f039-47ce-a470-a662b129930a_-browser-action" "dontfuckwithpaste_raim_ist-browser-action" "vimium-c_gdh1995_cn-browser-action" "_setupvpncom-browser-action" "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action" "_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action"];
              "nav-bar" = ["back-button" "forward-button" "stop-reload-button" "customizableui-special-spring1" "urlbar-container" "customizableui-special-spring2" "downloads-button" "addon_darkreader_org-browser-action" "ublock0_raymondhill_net-browser-action" "sponsorblocker_ajay_app-browser-action" "unified-extensions-button"];
              "toolbar-menubar" = ["menubar-items"];
              "TabsToolbar" = ["tabbrowser-tabs" "new-tab-button" "alltabs-button"];
              "PersonalToolbar" = ["personal-bookmarks"];
            };
            "seen" = ["developer-button" "_531906d3-e22f-4a6c-a102-8057b88a1a63_-browser-action" "ublock0_raymondhill_net-browser-action" "skipredirect_sblask-browser-action" "_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action" "smart-referer_meh_paranoid_pk-browser-action" "addon_darkreader_org-browser-action" "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action" "sponsorblocker_ajay_app-browser-action" "_74145f27-f039-47ce-a470-a662b129930a_-browser-action" "dontfuckwithpaste_raim_ist-browser-action" "vimium-c_gdh1995_cn-browser-action" "_setupvpncom-browser-action" "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action" "_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action"];
            "dirtyAreaCache" = ["nav-bar" "PersonalToolbar" "unified-extensions-area" "toolbar-menubar" "TabsToolbar"];
            "currentVersion" = 20;
            "newElementCount" = 5;
          };
        };
      };

      profiles.wolbyte = {
        id = 0;
        name = "wolbyte";
        isDefault = true;

        search = {
          default = "Brave";
          force = true;
          engines = {
            "Nix Packages" = {
              urls = [{template = "https://search.nixos.org/packages?type=packages&channel=unstable&query={searchTerms}";}];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };

            "Brave" = {
              urls = [{template = "http://search.brave.com/search?q={searchTerms}";}];
              iconUpdateURL = "https://cdn.search.brave.com/serp/v1/static/brand/eebf5f2ce06b0b0ee6bbd72d7e18621d4618b9663471d42463c692d019068072-brave-lion-favicon.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = ["@brave"];
            };
          };
        };
      };
    };
  };
}
