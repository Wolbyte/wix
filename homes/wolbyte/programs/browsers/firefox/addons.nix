let
  mkExt = url: {
    install_url = url;
    installation_mode = "force_installed";
  };
in
{
  # Bitwarden
  "{446900e4-71c2-419f-a6a7-df9c091e268b}" =
    mkExt "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";

  # Clear urls
  "{74145f27-f039-47ce-a470-a662b129930a}" =
    mkExt "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";

  # Darkreader
  "addon@darkreader.org" =
    mkExt "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";

  # DontFuckWithPaste
  "DontFuckWithPaste@raim.ist" =
    mkExt "https://addons.mozilla.org/firefox/downloads/latest/don-t-fuck-with-paste/latest.xpi";

  # Refined github
  "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" =
    mkExt "https://addons.mozilla.org/firefox/downloads/latest/refined-github-/latest.xpi";

  # Return YouTube dislikes
  "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" =
    mkExt "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";

  # Sponsorblock
  "sponsorBlocker@ajay.app" =
    mkExt "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";

  # Ublock Origin
  "uBlock0@raymondhill.net" =
    mkExt "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";

  # Vimium C
  "vimium-c@gdh1995.cn" =
    mkExt "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
}
