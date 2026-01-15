local builtin = require('telescope.builtin')

---------------
-- Telescope --
---------------

vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>sn', function()
    builtin.live_grep({ cwd = vim.fn.stdpath('config') })
end, { desc = '[S]earch [N]eovim Files' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzy Find in Buffer' })

---------
-- Oil --
---------

vim.keymap.set('n', '\\', '<cmd>Oil --float .<CR>', { desc = 'Open Oil file browser in cwd' })

---------
-- DAP --
---------

vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'Debug: Toggle [B]reakpoint' })
vim.keymap.set('n', '<leader>B', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'Debug: Conditional [B]reakpoint' })
vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end, { desc = '[D]ebug: Open [R]EPL' })
vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end, { desc = '[D]ebug: Run [L]ast' })
vim.keymap.set('n', '<leader>du', function() require('dapui').toggle() end, { desc = '[D]ebug: Toggle [U]I' })
