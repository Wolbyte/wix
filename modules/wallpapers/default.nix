{lib, ...}:
with lib;
with lib.wb; let
  wallpaperType = types.submodule {
    options = {
      path = mkOpt types.path null "The path to the wallpaper.";
    };
  };
in {
  options.wb.wallpaper = {
    normal = mkOpt wallpaperType null "Static wallpaper.";
    live = mkOpt wallpaperType null "Live wallpaper.";
    preferredType = defaultOpts.mkEnumFirstDefault ["normal" "live"] "The wallpaper type to try to use.";
  };

  options.wb.wallpapers =
    mkOpt types.attrs {} "Wallpapers to download.";

  config = {
    wb.wallpapers = let
      wallpapers = builtins.fromJSON (builtins.readFile ./list.json);
    in
      builtins.listToAttrs (map
        (wallpaper: let
          provider = wallpaper.provider or "direct";
          wallpaperUrl =
            if provider == "imgur"
            then "https://i.imgur.com/${wallpaper.id}.${wallpaper.ext}"
            else wallpaper.url;
        in {
          inherit (wallpaper) name;
          value = {
            path = builtins.fetchurl {
              inherit (wallpaper) sha256 name;
              url = wallpaperUrl;
            };
          };
        })
        wallpapers);
  };
}
