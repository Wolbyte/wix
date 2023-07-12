{
  self,
  lib,
  ...
}:
with lib;
with builtins;
with self.attrs; rec {
  getFileNameFromPath = path: removeSuffix ".nix" (baseNameOf path);

  mapFiles = dir:
    mapFilesPred dir
    (n: v: v != null && !(hasPrefix "_" n));

  mapFilesPred = dir: pred: fn:
    mapFilterAttrs
    pred
    (n: v: let
      path = "${toString dir}/${n}";
    in
      if v == "directory" && pathExists "${path}/default.nix"
      then nameValuePair n (fn path)
      else if
        v
        == "regular"
        && n != "default.nix"
        && hasSuffix ".nix" n
      then nameValuePair (getFileNameFromPath n) (fn path)
      else nameValuePair "" null)
    (readDir dir);

  mapFilesRecursive = dir: fn:
    mapFilterAttrs
    (n: v: v != null && !(hasPrefix "_" n))
    (n: v: let
      path = "${toString dir}/${n}";
    in
      if v == "directory"
      then nameValuePair n (mapFilesRecursive path fn)
      else if v == "regular" && n != "default.nix" && hasSuffix ".nix" n
      then nameValuePair (getFileNameFromPath n) (fn path)
      else nameValuePair "" null)
    (readDir dir);

  mapFilesRecursivePred' = dir: dirPred: filePred: fn: let
    dirs = mapAttrsToList (k: _: "${dir}/${k}") (filterAttrs dirPred (readDir dir));
    files = attrValues (mapFilesPred dir filePred id);
    paths = files ++ concatLists (map (d: mapFilesRecursivePred' d dirPred filePred id) dirs);
  in
    map fn paths;

  mapFilesRecursive' = dir:
    mapFilesRecursivePred' dir
    (n: v: v == "directory" && !(hasPrefix "_" n))
    (n: v: v != null && !(hasPrefix "_" n));
}
