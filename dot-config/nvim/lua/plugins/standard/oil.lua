return {
	"stevearc/oil.nvim",
	dependencies = { "echasnovski/mini.nvim" },
	cmd = "Oil",
	keys = {
		{ "-", "<cmd>Oil<cr>", desc = "Open parent directory (oil)" },
	},
	opts = {
		default_file_explorer = false,
		delete_to_trash = true,
		skip_confirm_for_simple_edits = false,
		view_options = {
			show_hidden = false,
		},
		keymaps = {
			["q"] = "actions.close",
			["<C-h>"] = false,
			["<C-l>"] = false,
		},
	},
}
