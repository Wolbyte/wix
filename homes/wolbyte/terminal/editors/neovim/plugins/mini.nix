{
  programs.nixvim = {
    plugins.mini = {
      enable = true;

      modules = {
        bufremove = {};

        comment = {
          custom_commentstring.__raw = ''
            function()
              return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
            end
          '';
        };

        surround = {
          mappings = {
            add = "gza";
            delete = "gzd";
            find = "gzf";
            find_left = "gzF";
            highlight = "gzh";
            replace = "gzr";
            update_n_lines = "gzn";
          };
        };
      };
    };
  };
}
