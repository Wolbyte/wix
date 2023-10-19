{lib, ...}:
with lib; rec {
  mkOpt = type: default: desc:
    mkOption {inherit type default;};

  mkPackageOpt = name: default:
    mkOpt types.package default "Package to use for ${name}.";

  defaultOpts = rec {
    mkAttrs = mkOpt types.attrs;

    mkBool = mkOpt types.bool;

    mkEnum = enum: mkOpt (types.enum enum);

    mkEnumFirstDefault = enum: mkEnum enum (head enum);

    mkInt = mkOpt types.int;

    mkStr = mkOpt types.str;
  };

  defaultNullOpts = rec {
    mkNullable = type: default: desc: let
      defaultDesc = "default: ${default}";
    in
      mkOpt (types.nullOr type) default (
        if desc == ""
        then defaultDesc
        else ''
          ${desc}

          ${defaultDesc}
        ''
      );

    mkStr = mkNullable types.str;
  };
}
