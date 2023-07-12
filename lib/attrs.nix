{lib, ...}:
with builtins;
with lib; {
  attrsToList = mapAttrsToList (name: value: {inherit name value;});

  mapFilterAttrs = pred: f: attrs: filterAttrs pred (mapAttrs' f attrs);
}
