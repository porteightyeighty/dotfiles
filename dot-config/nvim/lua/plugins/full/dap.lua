return {
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
    },
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      { "<leader>do", function() require("dap").step_over() end, desc = "[D]ebug: Step [O]ver" },
      { "<leader>di", function() require("dap").step_into() end, desc = "[D]ebug: Step [I]nto" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "[D]ebug: Step [O]ut" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle [B]reakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Debug: Conditional [B]reakpoint" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "[D]ebug: Open [R]EPL" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "[D]ebug: Run [L]ast" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "[D]ebug: Toggle [U]I" },
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      dapui.setup({
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      })

      -- Automatically open/close DAP UI
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
    end,
  },
}
