return {
	{
		"Mofiqul/vscode.nvim",
		name = "vscode",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("vscode")
			vim.o.background = "light"
		end,
	},
}
