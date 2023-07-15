{pkgs, ...}: let
  icons = import ../icons.nix;
  helpers = import ../helpers.nix;

  nvimPython = pkgs.python310.withPackages (ps: [
    ps.debugpy
  ]);
in {
  programs.nixvim = {
    plugins.dap = {
      enable = true;

      adapters.servers = {
        cpp = {
          port = "$\{port}";
        };
      };

      configurations = {
        cpp = [
          {
            name = "Cxx";
            request = "attach";
            type = "cpp";
            program = "gdb";
          }
        ];
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

      extensions = {
        dap-python = {
          enable = true;
          adapterPythonPath = "${nvimPython}/bin/python3.10";
          includeConfigs = true;
        };

        dap-ui = {
          enable = true;

          elementMappings = {
            scopes.edit = "r";
          };
        };

        dap-virtual-text.enable = true;
      };
    };

    maps = with helpers; {
      normal = {
        "<leader>d" = {desc = "Debug";};
        "<leader>db" = mkLuaKeybind "require('dap').toggle_breakpoint" "Toggle Breakpoint";
        "<leader>dc" = mkLuaKeybind "require('dap').continue" "Start/Continue";
        "<leader>dC" = mkLuaKeybind ''
          function()
            vim.ui.input({prompt = "Condition: "}, function(condition)
              if condition then require('dap').set_breakpoint(condition) end
            end)
          end
        '' "Conditional Breakpoint";
        "<leader>dp" = mkLuaKeybind "require('dap').pause" "Pause";
        "<leader>dq" = mkLuaKeybind "require('dap').close" "Close Session";
        "<leader>dQ" = mkLuaKeybind "require('dap').terminate" "Terminate Session";
        "<leader>dr" = mkLuaKeybind "require('dap').restart_frame" "Restart";
        "<leader>di" = mkLuaKeybind "require('dap').step_into" "Step Into";
        "<leader>do" = mkLuaKeybind "require('dap').step_over" "Step Over";
        "<leader>dO" = mkLuaKeybind "require('dap').step_out" "Step Out";
        "<leader>dR" = mkLuaKeybind "require('dap').repl.toggle" "Toggle REPL";
        "<leader>ds" = mkLuaKeybind "require('dap').run_to_cursor" "Run To Cursor";
        "<leader>de" = mkLuaKeybind ''
          function()
            vim.ui.input({prompt = "Expression: "}, function(expr)
              if expr then require("dapui").eval(expr); end
            end)
          end
        '' "Evaluate Input";
        "<leader>du" = mkLuaKeybind "require('dapui').toggle" "Toggle Debugger UI";
        "<leader>dh" = mkLuaKeybind "require('dap.ui.widgets').hover" "Debugger Hover";
      };

      visual = {
        "<leader>de" = mkLuaKeybind "require('dapui').eval" "Evaluate Selection";
      };
    };
  };
}
