{
  pkgs,
  config,
  ...
}:
let
  mkPlug = name: file: src: { inherit name file src; };
in
{
  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;

    syntaxHighlighting.enable = true;

    enableCompletion = true;

    dotDir = ".config/zsh";

    history = {
      path = "${config.xdg.stateHome}/zsh/history";
      append = true;
      share = true;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 10000;
      size = 10000;
    };

    historySubstringSearch.enable = true;

    completionInit = ''
      zstyle ":completion:*" menu no # Disable the default zsh menu
      zstyle ":completion:*:descriptions" format '[%d]'
      zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}" "m:{A-Z}={a-zA-z}"

      # Colors
      zstyle ":completion:*" list-colors ''${(s.:.)LS_COLORS}

      # zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons=always --color=always $realpath'
      zstyle ':fzf-tab:complete:*:*' fzf-preview 'bat --color=always --style=numbers --line-range=:200 $realpath 2>/dev/null || eza --color=always --icons=always $realpath'

      zstyle ':fzf-tab:*' switch-group ',' '.'
    '';

    initExtra = ''
      set -k

      ZSH_AUTOSUGGEST_USE_ASYNC="true"

      export FZF_DEFAULT_OPTS="
      --color gutter:-1
      --color bg:-1
      --color bg+:-1
      --pointer '➜ '
      --layout=reverse
      -m --bind ctrl-space:toggle,ctrl-p:preview-up,ctrl-n:preview-down
      "

      # Colors
      autoload -Uz colors && colors
    '';

    plugins = with pkgs; [
      (mkPlug "fzf-tab" "share/fzf-tab/fzf-tab.plugin.zsh" zsh-fzf-tab)

      (mkPlug "zsh-vi-mode" "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh" zsh-vi-mode)

      (mkPlug "zsh-nix-shell" "share/zsh-nix-shell/nix-shell.plugin.zsh" zsh-nix-shell)
    ];
  };
}
