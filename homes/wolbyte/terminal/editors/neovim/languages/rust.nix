{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      crates-nvim.enable = true;

      none-ls.sources = {
        # formatting.rustfmt.enable = true;
      };

      rust-tools = {
        enable = true;

        inlayHints.maxLenAlign = true;

        hoverActions.autoFocus = true;

        server = {
          cargo.features = "all";
          checkOnSave = true;
          check.command = "clippy";
        };

        extraOptions = {
          # https://github.com/simrat39/rust-tools.nvim/wiki/Debugging#codelldb-a-better-debugging-experience
          dap.adapter.__raw = let
            codelldb = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/";
          in "require('rust-tools.dap').get_codelldb_adapter('${codelldb}/adapter/codelldb', '${codelldb}/lldb/lib/liblldb.so')";

          server.on_attach.__raw = ''
            function(_, bufnr)
              vim.keymap.set("n", "<leader>dc", function()
                if require("dap").session() == nil then
                  require("rust-tools").debuggables.debuggables()
                else
                  require("dap").continue()
                end
              end, {buffer = bufnr, desc = "Start/Continue"})
            end
          '';
        };
      };
    };
  };
}
