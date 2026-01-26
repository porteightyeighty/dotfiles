-----------------
-- vim options --
-----------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.breakindent = true -- when wrapping text, continue at the same indent level
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
vim.g.have_nerd_font = false

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Search settings

vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Visual sesttings
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.showmatch = true
vim.opt.matchtime = 2 -- How long to show matching bracket
vim.opt.cmdheight = 0 -- Command line height
vim.opt.completeopt = "menuone,noinsert,noselect" -- Completion options
vim.opt.showmode = false -- Don't show mode in command line
vim.opt.pumheight = 10 -- Popup menu height
vim.opt.pumblend = 10 -- Popup menu transparency
vim.opt.winblend = 0 -- Floating window transparency
vim.opt.conceallevel = 0 -- Don't hide markup
vim.opt.concealcursor = "" -- Don't hide cursor line markup
vim.opt.lazyredraw = true -- Don't redraw during macros
vim.opt.synmaxcol = 300 -- Syntax highlighting limit
vim.opt.list = true -- Displays whitespace where the cursor is.
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.g.tpipeline_autoembed = 0

-- File handling
vim.opt.backup = false -- Don't create backup files
vim.opt.writebackup = false -- Don't create backup before writing
vim.opt.swapfile = true
vim.opt.directory = vim.fn.expand("~/.local/state/nvim/swap") .. "//"
vim.opt.undofile = true -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory
vim.opt.updatetime = 300 -- Faster completion
vim.opt.timeoutlen = 500 -- Key timeout duration
vim.opt.ttimeoutlen = 0 -- Key code timeout
vim.opt.autoread = true -- Auto reload files changed outside vim
vim.opt.autowrite = false -- Don't auto save

-- Behavior settings
vim.opt.hidden = true -- Allow hidden buffers
vim.opt.errorbells = false -- No error bells
vim.opt.backspace = "indent,eol,start" -- Better backspace behavior
vim.opt.autochdir = false -- Don't auto change directory
vim.opt.selection = "exclusive" -- Selection behavior
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard
vim.opt.modifiable = true -- Allow buffer modifications
vim.opt.encoding = "UTF-8" -- Set encoding

-- Split behaviour
vim.opt.splitright = true -- vertical splits
vim.opt.splitbelow = true -- horizontal splits

-- Cursor settings
-- vim.opt.guicursor = { "a:blinkwait700-blinkoff400-blinkon400" }

-- preview substitions (:%s/foo/bar)
vim.opt.inccommand = "split"

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- Fold Options
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

-------------------
-- Basic Keymaps --
-------------------

-- Visual line movement
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", function()
	vim.notify("Use h to move!!")
end)
vim.keymap.set("n", "<right>", function()
	vim.notify("Use l to move!!")
end)
vim.keymap.set("n", "<up>", function()
	vim.notify("Use h to move!!")
end)
vim.keymap.set("n", "<down>", function()
	vim.notify("use k to move!!")
end)

--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Y to EOL
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bx", ":bdelete<CR>", { desc = "Close buffer" })

-- Splitting & Resizing
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>", { desc = "Split [w]indow [v]ertically" })
vim.keymap.set("n", "<leader>wh", ":split<CR>", { desc = "Split [w]indow [h]orizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

------------------
-- Autocommands --
------------------

local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		local line = mark[1]
		local ft = vim.bo.filetype
		if
			line > 0
			and line <= lcount
			and vim.fn.index({ "commit", "gitrebase", "xxd" }, ft) == -1
			and not vim.o.diff
		then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Set filetype-specific settings
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "lua", "python" },
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})

---------------------------
-- Command aliases --
---------------------------

-- I really struggle not to keep shift held down while executing these commands, so papering over the cracks with this!
vim.cmd("command! Wq wq")
vim.cmd("command! WQ wq")
vim.cmd("command! W w")
vim.cmd("command! Q quit")


-------------------------
-- Lazy Plugin Manager --
-------------------------

require("config.lazy")
require("config.mappings")

----------------
-- LSP Config --
----------------

require("config.lsp")

----------------
-- Treesitter --
----------------

treesitter_ensure_installed = {
	"apex",
	"c",
	"java",
	"javascript",
	"json",
	"lua",
	"rust",
	"soql",
	"sosl",
	"sql",
	"tmux",
	"vim",
	"vue",
	"xml",
	"zig",
	"zsh",
}
require("nvim-treesitter").install(treesitter_ensure_installed)
