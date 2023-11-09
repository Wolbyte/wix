{lib, ...}: let
  icons = import ../icons.nix;
  helpers = import ../helpers.nix {inherit lib;};
in {
  programs.nixvim = {
    plugins = {
      dap = {
        enable = true;

        signs = {
          dapBreakpoint = {
            text = icons.dapBreakpoint;
            texthl = "DiagnosticInfo";
          };
          dapBreakpointCondition = {
            text = icons.dapBreakpointCondition;
            texthl = "DiagnosticInfo";
          };
          dapBreakpointRejected = {
            text = icons.dapBreakpointRejected;
            texthl = "DiagnosticError";
          };
          dapLogPoint = {
            text = icons.dapLogPoint;
            texthl = "DiagnosticInfo";
          };
          dapStopped = {
            text = icons.dapStopped;
            texthl = "DiagnosticWarn";
          };
        };

        extensions = {
          dap-ui.enable = true;

          dap-virtual-text.enable = true;
        };
      };
    };

    keymaps = with helpers;
      mkKeymaps {
        n = {
          "<leader>db" = mkLuaMap "require('dap').toggle_breakpoint" "Toggle Breakpoint";
          "<leader>dc" = mkLuaMap "require('dap').continue" "Start/Continue";
          "<leader>dC" = mkLuaMap ''
            function()
              vim.ui.input({prompt = "Condition: "}, function(condition)
                if condition then require('dap').set_breakpoint(condition) end
              end)
            end
          '' "Conditional Breakpoint";
          "<leader>dp" = mkLuaMap "require('dap').pause" "Pause";
          "<leader>dq" = mkLuaMap "require('dap').close" "Close Session";
          "<leader>dQ" = mkLuaMap "require('dap').terminate" "Terminate Session";
          "<leader>dr" = mkLuaMap "require('dap').restart_frame" "Restart";
          "<leader>di" = mkLuaMap "require('dap').step_into" "Step Into";
          "<leader>do" = mkLuaMap "require('dap').step_over" "Step Over";
          "<leader>dO" = mkLuaMap "require('dap').step_out" "Step Out";
          "<leader>dR" = mkLuaMap "require('dap').repl.toggle" "Toggle REPL";
          "<leader>ds" = mkLuaMap "require('dap').run_to_cursor" "Run To Cursor";
          "<leader>de" = mkLuaMap ''
            function()
              vim.ui.input({prompt = "Expression: "}, function(expr)
                if expr then require("dapui").eval(expr); end
              end)
            end
          '' "Evaluate Input";
          "<leader>du" = mkLuaMap "require('dapui').toggle" "Toggle Debugger UI";
          "<leader>dh" = mkLuaMap "require('dap.ui.widgets').hover" "Debugger Hover";
        };

        v = {
          "<leader>de" = mkLuaMap "require('dapui').eval" "Evaluate Selection";
        };
      };
  };
}
