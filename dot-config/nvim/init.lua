# Vim Options

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
