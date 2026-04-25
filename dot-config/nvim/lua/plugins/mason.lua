return {
	{ "mason-org/mason.nvim", cmd = "Mason", opts = {} },
	{ "neovim/nvim-lspconfig", event = "VeryLazy" },
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = { "mason-org/mason.nvim" },
		config = function()
			local mason_names = vim.tbl_values(require("config.servers"))
			vim.list_extend(mason_names, {
				"java-debug-adapter",
				"java-test",
				"google-java-format",
			})
			require("mason-tool-installer").setup({
				ensure_installed = mason_names,
				auto_update = false,
				run_on_start = true,
			})
		end,
	},
}
