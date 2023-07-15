let
  helpers = import ../helpers.nix;
in {
  programs.nixvim = {
    plugins = {
      comment-nvim = {
        enable = true;
      };
    };
  };
}
