{
  modifications = self: super: {
    spotify = super.spotify.overrideAttrs (old: rec {
      version = "1.2.13.661.ga588f749";
      rev = "68";
      src = super.fetchurl {
        url = "https://api.snapcraft.io/api/v1/snaps/download/pOBIoZ2LrCB3rDohMxoYGnbN14EHOgD7_${rev}.snap";
        sha256 = "sha256-UbA0HHLCnENO3e3c+wOeuJ9F9d19S5MAQ6zEg2hitwk=";
      };
      unpackPhase = builtins.replaceStrings ["${old.version}"] ["${version}"] old.unpackPhase;
    });
  };
}
