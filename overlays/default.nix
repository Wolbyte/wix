{
  modifications = self: super: {
    spotify = super.spotify.overrideAttrs (old: rec {
      version = "1.2.11.916.geb595a67";
      rev = "67";
      src = super.fetchurl {
        url = "https://api.snapcraft.io/api/v1/snaps/download/pOBIoZ2LrCB3rDohMxoYGnbN14EHOgD7_${rev}.snap";
        sha256 = "sha256-v77yoVea1Eec2KCqIXMfa1aLuKP/ghX9lizzIYX8DSk=";
      };
      unpackPhase = builtins.replaceStrings ["${old.version}"] ["${version}"] old.unpackPhase;
    });
  };
}
