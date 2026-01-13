-----------------
-- Vim Options --
-----------------

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = false

vim.o.number = true
vim.o.relativenumber = false
vim.o.shiftwidth = 4

vim.o.mouse = 'a'

-- TODO: turn off once a status line plugin is configured
-- vim.o.showmode = false

vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

-- when wrapping text, continue at the same indent level
vim.o.breakindent = true

-- log undo history to an undo file
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- show signs in number column if they're relevant, change to add a new column for signs.
vim.o.signcolumn = 'number'

-- If this many milliseconds nothing is typed the swap file will be written to disk
-- default: 4000
vim.o.updatetime = 250

-- Configure how new splits should be opened
-- vertical splits
vim.o.splitright = true
-- horizontal splits
vim.o.splitbelow = true

-- Displays whitespace where the cursor is.
vim.o.list = true

vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- preview substitions (:%s/foo/bar)
vim.o.inccommand = 'split'

--highlight current line
vim.o.cursorline = true


-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-------------------
-- Basic Keymaps --
-------------------

-- Visual line movement
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

---------------------------
-- Command aliases --
---------------------------


-- I really struggle not to keep shift held down while executing these commands, so papering over the cracks with this!
vim.cmd('command! Wq wq')
vim.cmd('command! WQ wq')
vim.cmd('command! W w')
vim.cmd('command! Q quit')

-------------------------
-- Lazy Plugin Manager --
-------------------------

require("config.lazy")


-- Treesitter
treesitter_ensure_installed = {
    'apex',
    'c',
    'java',
    'javascript',
    'json',
    'lua',
    'rust',
    'soql',
    'sql',
    'tmux',
    'vim',
    'vimdoc',
    'vue',
    'xml',
    'zig',
    'zsh'
}
require'nvim-treesitter'.install(treesitter_ensure_installed) 

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() 
    vim.treesitter.start() 
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
  end,
})
