{
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib; let
  inherit (osConfig.wb) device;

  rose-pine-theme = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "discord";
    rev = "6fe51f94abaa05b6660924a35c9827ac2d18dffe";
    hash = "sha256-ATi0/gwLB9B50u+3VIXt7C9ttbhAzIfeFZtNdL610JQ=";
  };

  acceptedTypes = ["desktop" "hybrid"];
in {
  config = mkIf (builtins.elem device.profile acceptedTypes) {
    home.packages = with pkgs; [
      ((discord-canary.override {
          nss = pkgs.nss_latest;
          withOpenASAR = false;
          withVencord = true;
        })
        .overrideAttrs (old: {
          libPath = old.libPath + ":${pkgs.libglvnd}/lib";
          nativeBuildInputs = old.nativeBuildInputs ++ [pkgs.makeWrapper];

          postFixup = ''
            wrapProgram $out/opt/DiscordCanary/DiscordCanary --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform=wayland}}"
          '';
        }))
    ];

    xdg.configFile."Vencord/themes/rose-pine.theme.css".source = "${rose-pine-theme}/rose-pine.theme.css";
  };
}
