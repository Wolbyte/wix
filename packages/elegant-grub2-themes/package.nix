{
  lib,
  stdenv,
  fetchFromGitHub,
  imagemagick,
  lsb-release,
  theme ? "forest",
  type ? "window",
  side ? "left",
  color ? "dark",
  size ? "1080p",
  logo ? "default",
}:
let
  validThemes = [
    "forest"
    "mojave"
    "mountain"
    "wave"
  ];
  validTypes = [
    "window"
    "float"
    "sharp"
    "blur"
  ];
  validSides = [
    "left"
    "right"
  ];
  validColors = [
    "dark"
    "light"
  ];
  validSizes = [
    "1080p"
    "2k"
    "4k"
  ];
  validLogos = [
    "default"
    "system"
  ];

  single = x: lib.optional (x != null) x;
  pname = "elegant-grub2-themes";
in
lib.checkListOfEnum "${pname} Valid theme name" validThemes (single theme) lib.checkListOfEnum
  "${pname} Valid theme style variant"
  validTypes
  (single type)
  lib.checkListOfEnum
  "${pname} Valid background side"
  validSides
  (single side)
  lib.checkListOfEnum
  "${pname} Valid theme color"
  validColors
  (single color)
  lib.checkListOfEnum
  "${pname} Valid sizes"
  validSizes
  (single size)
  lib.checkListOfEnum
  "${pname} Valid logo on image (defualt is a mountain)"
  validLogos
  (single logo)

  stdenv.mkDerivation
  {
    inherit pname;
    version = "0-unstable-2025-09-13";

    src = fetchFromGitHub {
      owner = "vinceliuice";
      repo = "Elegant-grub2-themes";
      rev = "92cdac334cf7bc5c1d68c2fbb266164653b4b502";
      hash = "sha256-fbZLWHxnLBrqBrS2MnM2G08HgEM2dmZvitiCERie0Cc=";
    };

    nativeBuildInputs = [
      imagemagick
      lsb-release
    ];

    postPatch = ''
      find -name "*.sh" -print0 | while IFS= read -r -d ''' file; do
        patchShebangs "$file"
      done
    '';

    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/grub/themes/

      ./generate.sh \
        --dest "$out/grub/themes/" \
        --theme ${theme} \
        --type ${type} \
        --side ${side} \
        --color ${color} \
        --screen ${size} \
        --logo ${logo} \

      runHook postInstall
    '';

    meta = {
      description = "Elegant grub2 themes for all linux systems";
      homepage = "https://github.com/vinceliuice/Elegant-grub2-themes";
      license = lib.licenses.gpl3Only;
      platforms = lib.platforms.all;
    };
  }
