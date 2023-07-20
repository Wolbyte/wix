{
  config,
  inputs,
  lib,
  options,
  ...
}:
with lib;
with lib.wb; {
  options = with types; {
    user = mkOpt attrs {} "Options for the primary user.";

    dotfiles = {
      dir = mkOpt path "${config.user.home}/.config" "";
      binDir = mkOpt path "${config.dotfiles.dir}/bin" "";
      configDir = mkOpt path "${config.dotfiles.dir}/config" "";
      modulesDir = mkOpt path "${config.dotfiles.dir}/modules" "";
    };

    hm = mkOpt attrs {} "Options for user's home-manager";

    env = mkOption {
      type = attrsOf (oneOf [str path (listOf (either str path))]);
      apply =
        mapAttrs
        (n: v:
          if isList v
          then concatMapStringsSep ":" toString v
          else (toString v));
      default = {};
    };
  };

  config = {
    user = let
      user = builtins.getEnv "USER";
      name =
        if elem user ["" "root"]
        then "wolbyte"
        else user;
    in {
      inherit name;
      description = "The primary user account";
      extraGroups = ["wheel" "video" "audio" "storage" "networkmanager"];
      isNormalUser = true;
      home = "/home/${name}";
      group = "users";
      uid = 1001;
    };

    home-manager = {
      useUserPackages = true;

      users.${config.user.name} = mkAliasDefinitions options.hm;
    };

    hm = {
      imports = [inputs.hyprland.homeManagerModules.default];
      home = {
        inherit (config.system) stateVersion;
      };
    };

    users.users.${config.user.name} = mkAliasDefinitions options.user;

    nix.settings = let
      users = ["root" config.user.name];
    in {
      trusted-users = users;
      allowed-users = users;
    };

    env.PATH = ["$DOTFILES_BIN" "$XDG_BIN_HOME" "$PATH"];

    environment.extraInit =
      concatStringsSep "\n"
      (mapAttrsToList (n: v: "export ${n}=\"${v}\"") config.env);
  };
}
