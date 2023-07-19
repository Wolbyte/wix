{lib, ...}:
with lib;
with lib.wb; {
  options.wb.wallpaper = {
    path = mkOpt types.path null "The path to the wallpaper.";
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
          value = builtins.fetchurl {
            inherit (wallpaper) sha256 name;
            url = wallpaperUrl;
          };
        })
        wallpapers);
  };
}
