{
  programs.nixvim = {
    autoCmd = [
      {
        description = "Highligh yanked text";
        callback.__raw = "function() vim.highlight.on_yank() end";
        event = "TextYankPost";
        group = "highlightYank";
        pattern = "*";
      }
    ];

    autoGroups = {
      highlightYank = {clear = true;};
    };
  };
}
