{
  programs.nixvim = {
    plugins.indent-blankline = {
      enable = true;
      showCurrentContext = true;
      showCurrentContextStart = true;
      useTreesitter = true;
      char = "▏";
      contextChar = "▏";

      buftypeExclude = [
        "nofile"
        "terminal"
      ];

      filetypeExclude = [
        "help"
        "startify"
        "aerial"
        "alpha"
        "dashboard"
        "lazy"
        "neogitstatus"
        "NvimTree"
        "neo-tree"
        "Trouble"
      ];

      contextPatterns = [
        "class"
        "return"
        "function"
        "method"
        "^if"
        "^while"
        "jsx_element"
        "^for"
        "^object"
        "^table"
        "block"
        "arguments"
        "if_statement"
        "else_clause"
        "jsx_element"
        "jsx_self_closing_element"
        "try_statement"
        "catch_clause"
        "import_statement"
        "operation_type"
      ];
    };
  };
}
