{lib, ...}:
with lib; rec {
  mkOpt = type: default: desc:
    mkOption {inherit type default;};

  defaultOpts = rec {
    mkAttrs = mkOpt types.attrs;

    mkBool = mkOpt types.bool;

    mkEnum = enum: mkOpt (types.enum enum);

    mkEnumFirstDefault = enum: mkEnum enum (head enum);

    mkInt = mkOpt types.int;

    mkStr = mkOpt types.str;
  };

  mkPackageOpt = name: default:
    mkOpt types.package default "Package to use for ${name}.";
}
