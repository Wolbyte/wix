let
  helpers = import ../../helpers.nix;
  icons = import ../../icons.nix;
in
  with helpers; {
    programs.nixvim = {
      plugins.dap = {
        enable = true;

        extensions = {
          dap-ui.enable = true;

          dap-virtual-text.enable = true;
        };

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
      };

      extraConfigLuaPost = ''
        local __dap = require("dap")
        local __dapui = require("dapui");

        __dap.listeners.after.event_initialized["dapui_config"] = function()
          __dapui.open({})
        end
        __dap.listeners.before.event_terminated["dapui_config"] = function()
          __dapui.close({})
        end
        __dap.listeners.before.event_exited["dapui_config"] = function()
          __dapui.close({})
        end
      '';

      keymaps = [
        (mkLuaKeymap "<leader>db" ["n"] "require('dap').toggle_breakpoint" {desc = "Toggle Breakpoint";})
        (mkLuaKeymap "<leader>dc" ["n"] "require('dap').continue" {desc = "Start/Continue";})
        (mkLuaKeymap "<leader>dC" ["n"] ''
          function()
            vim.ui.input({prompt = "Condition: "}, function(condition)
              if condition then require('dap').set_breakpoint(condition) end
            end)
          end
        '' {desc = "Conditional Breakpoint";})
        (mkLuaKeymap "<leader>dp" ["n"] "require('dap').pause" {desc = "Pause";})
        (mkLuaKeymap "<leader>dq" ["n"] "require('dap').close" {desc = "Close Session";})
        (mkLuaKeymap "<leader>dQ" ["n"] "require('dap').terminate" {desc = "Terminate Session";})
        (mkLuaKeymap "<leader>dr" ["n"] "require('dap').restart_frame" {desc = "Restart";})
        (mkLuaKeymap "<leader>di" ["n"] "require('dap').step_into" {desc = "Step Into";})
        (mkLuaKeymap "<leader>do" ["n"] "require('dap').step_over" {desc = "Step Over";})
        (mkLuaKeymap "<leader>dO" ["n"] "require('dap').step_out" {desc = "Step Out";})
        (mkLuaKeymap "<leader>dR" ["n"] "require('dap').repl.toggle" {desc = "Toggle REPL";})
        (mkLuaKeymap "<leader>ds" ["n"] "require('dap').run_to_cursor" {desc = "Run To Cursor";})
        (mkLuaKeymap "<leader>de" ["n"] ''
          function()
            vim.ui.input({prompt = "Expression: "}, function(expr)
              if expr then require("dapui").eval(expr); end
            end)
          end
        '' {desc = "Evaluate Input";})
        (mkLuaKeymap "<leader>du" ["n"] "require('dapui').toggle" {desc = "Toggle Debugger UI";})
        (mkLuaKeymap "<leader>dh" ["n"] "require('dap.ui.widgets').hover" {desc = "Debugger Hover";})
        (mkLuaKeymap "<leader>de" ["v"] "require('dapui').eval" {desc = "Evaluate Selection";})
      ];
    };
  }
