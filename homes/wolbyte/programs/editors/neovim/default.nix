{ pkgs, inputs, ... }:
{
  xdg.configFile."nvim" = {
    recursive = true;
    source = inputs.neovim-config;
  };

  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      LazyVim
    ];

    extraPackages = with pkgs; [
      gcc
      tree-sitter

      inotify-tools

      # LazyVim defaults
      stylua
      shfmt

      # Languages

      # Clangd
      llvmPackages_18.clang-tools
      llvmPackages_18.clang

      # CMake
      neocmakelsp
      cmake-lint

      # Docker
      dockerfile-language-server
      docker-compose-language-service
      hadolint

      # Go
      gopls
      golangci-lint
      impl
      gomodifytags
      gofumpt
      gotools

      # HTML, CSS, JSON
      vscode-langservers-extracted

      # JSON and YAML extras
      yaml-language-server

      # lua
      lua-language-server

      # Markdown
      markdownlint-cli2
      marksman

      # Nix
      nixd
      statix

      # Python
      pyright
      ruff
    ];
  };
}
