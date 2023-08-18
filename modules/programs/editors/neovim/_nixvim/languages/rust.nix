{pkgs, ...}: {
  programs.nixvim = {
    plugins.rust-tools = {
      enable = true;

      hoverActions.autoFocus = true;

      extraOptions = {
        # https://github.com/simrat39/rust-tools.nvim/wiki/Debugging#codelldb-a-better-debugging-experience
        dap.adapter.__raw = let
          codelldb = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/";
        in "require('rust-tools.dap').get_codelldb_adapter('${codelldb}/adapter/codelldb', '${codelldb}/lldb/lib/liblldb.so')";
      };
    };
  };
}
