-----------------
-- vim options --
-----------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- basic settings
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.breakindent = true -- when wrapping text, continue at the same indent level
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
vim.g.have_nerd_font = true

-- Indentation
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

vim.opt.completeopt = "menuone,noinsert,noselect" -- Completion options
vim.opt.showmode = false -- Don't show mode in command line
vim.opt.pumheight = 10 -- Popup menu height
vim.opt.pumblend = 10 -- Popup menu transparency
vim.opt.winblend = 0 -- Floating window transparency
vim.opt.conceallevel = 0 -- Don't hide markup
vim.opt.concealcursor = "" -- Don't hide cursor line markup
vim.opt.synmaxcol = 300 -- Syntax highlighting limit
vim.opt.list = true -- Displays whitespace where the cursor is.
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

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

-- Filetype detection
vim.filetype.add({
	extension = {
		cls = function(path)
			-- Only treat .cls as Apex if inside a Salesforce project
			if vim.fn.findfile("sfdx-project.json", vim.fn.fnamemodify(path, ":h") .. ";") ~= "" then
				return "apex"
			end
			-- Fall through to default (LaTeX \documentclass)
		end,
		trigger = "apex",
		apex = "apex",
	},
	pattern = {
		[".*/aura/[^/]+/[^/]+%.cmp"] = "html",
		[".*/aura/[^/]+/[^/]+%.app"] = "html",
		[".*/aura/[^/]+/[^/]+%.evt"] = "html",
		[".*/aura/[^/]+/[^/]+%.intf"] = "html",
	},
})
