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

        Preferences = import ./settings.nix { inherit config; };
        ExtensionSettings = import ./addons.nix;
      };

      profiles.wolbyte = {
        id = 0;
        name = "wolbyte";
        isDefault = true;

        search = {
          force = true;

          engines = {
            "NixPackages" = {
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
              urls = [
                {
                  template = "https://search.nixos.org/packages?type=packages&channel=unstable&query={searchTerms}";
                }
              ];
            };

            "HomeManager Options" = {
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@hm" ];
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
                }
              ];
            };
          };
        };
      };
    };
  };
}
