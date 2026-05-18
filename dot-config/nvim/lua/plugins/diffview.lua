return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh" },
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "[G]it [D]iffview (working tree)" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "[G]it file [H]istory (current file)" },
		{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "[G]it file [H]istory (repo)" },
		{ "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "[G]it diffview [C]lose" },
	},
	opts = {},
}
