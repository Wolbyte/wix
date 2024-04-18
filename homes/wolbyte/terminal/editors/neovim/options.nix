{
  programs.nixvim = {
    clipboard.register = "unnamedplus";

    opts = {
      breakindent = true;
      cmdheight = 0;
      copyindent = true;
      cursorline = true;
      expandtab = true;
      fileencoding = "utf-8";
      fillchars.eob = " ";
      foldenable = true;
      foldlevel = 99;
      foldlevelstart = 99;
      foldcolumn = "0";
      history = 100;
      ignorecase = true;
      infercase = true;
      laststatus = 3;
      linebreak = true;
      mouse = "a";
      number = true;
      preserveindent = true;
      pumheight = 10;
      relativenumber = true;
      scrolloff = 8;
      shiftwidth = 2;
      showmode = false;
      showtabline = 2;
      sidescrolloff = 8;
      signcolumn = "yes";
      smartcase = true;
      smartindent = true;
      splitbelow = true;
      splitright = true;
      tabstop = 2;
      termguicolors = true;
      timeoutlen = 500;
      undofile = true;
      updatetime = 300;
      virtualedit = "block";
      wrap = false;
      writebackup = false;
    };
  };
}
