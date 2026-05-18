return {
	"nvim-treesitter/nvim-treesitter-context",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		max_lines = 3,
		multiline_threshold = 1,
		trim_scope = "outer",
	},
	keys = {
		{ "<leader>cx", "<cmd>TSContextToggle<cr>", desc = "[C]ode conte[x]t toggle" },
	},
}
