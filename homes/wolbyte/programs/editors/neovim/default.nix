{ pkgs, inputs, ... }:
{
  xdg.configFile."nvim" = {
    recursive = true;
    source = inputs.neovim-config;
  };

  programs.neovim = {
    enable = true;

    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      LazyVim
    ];

    extraPackages = with pkgs; [
      gcc
      tree-sitter

      inotify-tools

      # LazyVim defaults
      ast-grep # grug-far
      lazygit
      shfmt
      stylua

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

      # Markdown & Latex
      markdownlint-cli2
      marksman
      python313Packages.pylatexenc
      tectonic

      # Nix
      nixd
      statix

      # Python
      pyright
      ruff
    ];
  };
}
