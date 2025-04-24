{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
with lib;
let
  inherit (config.wix) userPreferences;

  inherit (osConfig.wix) host;

  mkEngine = alias: icon: urlTemplate: {
    inherit icon;
    definedAliases = [ alias ];
    urls = [ { template = urlTemplate; } ];
  };

  nixIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
in
{
  config = mkIf (userPreferences.defaultPrograms.browser == "firefox" && host.enableDesktopFeatures) {
    programs.firefox = {
      enable = true;

      policies = {
        # QoL
        DisableAppUpdate = true;
        DontCheckDefaultBrowser = true;
        DisablePocket = true;

        # Privacy
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

        Preferences = import ./settings.nix { inherit lib config osConfig; };
        ExtensionSettings = import ./addons.nix;
      };

      profiles.wolbyte = {
        id = 0;
        name = "wolbyte";
        isDefault = true;

        search = {
          force = true;

          engines = {
            "NixPackages" =
              mkEngine "@np" nixIcon
                "https://search.nixos.org/packages?type=packages&channel=unstable&query={searchTerms}";

            "NixOptions" =
              mkEngine "@no" nixIcon
                "https://search.nixos.org/options?channel=unstable&type=packages&query={searchTerms}";

            "HomeManager Options" =
              mkEngine "@hm" nixIcon
                "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
          };
        };
      };
    };

    home.packages = [
      (pkgs.makeDesktopItem {
        name = "firefox-private";
        desktopName = "Firefox (private)";
        genericName = "Open a private Firefox window";
        icon = "firefox";
        exec = "firefox --private-window";
        categories = [ "Network" ];
      })
    ];
  };
}
