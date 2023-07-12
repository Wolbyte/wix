{
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  files = import ./files.nix {
    inherit lib;
    self.attrs = import ./attrs.nix {
      inherit lib;
      self = {};
    };
  };

  extensibleLib = makeExtensible (self:
    files.mapFiles ./. (
      file: import file {inherit self lib pkgs inputs;}
    ));
in
  extensibleLib.extend (
    self: super:
      foldr (a: b: a // b) {} (attrValues super)
  )
