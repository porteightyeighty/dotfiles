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

-- Restore Lazy's `s` (Sync) inside the Lazy UI, which flash.nvim's global `s`
-- otherwise shadows. Schedule to run after Lazy installs its own buffer maps.
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "lazy",
	callback = function(ev)
		vim.schedule(function()
			vim.keymap.set("n", "s", "<cmd>Lazy sync<cr>", { buffer = ev.buf, desc = "Lazy sync" })
		end)
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
