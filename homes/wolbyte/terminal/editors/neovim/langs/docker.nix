{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      lint.lintersByFt.docker = ["hadolint"];

      lsp.servers.dockerls.enable = true;
    };

    extraPackages = with pkgs; [hadolint];
  };
}
