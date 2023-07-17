{lib, ...}:
with lib; rec {
  mkOpt = type: default: desc:
    mkOption {inherit type default;};

  mkNullOrOpt = type: mkOpt (type.nullOr type) null;

  defaultOpts = rec {
    mkAttrs = mkOpt types.attrs;

    mkBool = mkOpt types.bool;

    mkEnum = enum: mkOpt (types.enum enum);

    mkEnumFirstDefault = enum: mkEnum enum (head enum);

    mkInt = mkOpt types.int;

    mkStr = mkOpt types.str;

    mkFont = kind: family: defaultPackage: {
      family = mkOpt types.str family "Family name for ${kind} font profile";

      package = mkPackageOpt "${kind} font profile" defaultPackage;
    };
  };

  defaultNullOpts = rec {
    mkNullalbe = type: default: desc: let
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

    mkStr = mkNullalbe types.str;
  };

  mkPackageOpt = name: default:
    mkOpt types.package default "Package to use for ${name}.";
}
