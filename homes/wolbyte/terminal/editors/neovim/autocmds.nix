{
  programs.nixvim = {
    autoCmd = [
      {
        desc = "Highligh yanked text";
        callback.__raw = "function() vim.highlight.on_yank() end";
        event = "TextYankPost";
        group = "highlightYank";
        pattern = "*";
      }
    ];

    autoGroups = {
      highlightYank = {clear = true;};
    };

    extraConfigLua = ''
      vim.on_key(function(char)
        if vim.fn.mode() == "n" then
          local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
          if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
        end
      end, vim.api.nvim_create_namespace "auto_hlsearch")
    '';
  };
}
