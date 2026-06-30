return {
	'nvim-treesitter/nvim-treesitter',
	event = { 'BufReadPost', 'BufNewFile' },
	build = ':TSUpdate',
	config = function()
		require("nvim-treesitter").install({
			"apex",
			"bash",
			"c",
			"css",
			"html",
			"java",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"mermaid",
			"python",
			"rust",
			"sflog",
			"soql",
			"sosl",
			"sql",
			"tmux",
			"toml",
			"typescript",
			"vim",
			"vimdoc",
			"vue",
			"xml",
			"yaml",
			"zig",
			"zsh",
		})

		-- nvim-treesitter main branch requires manual start per filetype
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})
	end,
}
