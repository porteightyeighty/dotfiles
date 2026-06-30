return {
	"gbprod/yanky.nvim",
	event = { "TextYankPost", "BufReadPost", "BufNewFile" },
	opts = {
		ring = {
			history_length = 100,
			storage = "shada",
			sync_with_numbered_registers = true,
			cancel_event = "update",
			ignore_registers = { "_" },
			update_register_on_cycle = false,
		},
		highlight = {
			on_put = true,
			on_yank = true,
			timer = 250,
		},
		preserve_cursor_position = { enabled = true },
		system_clipboard = { sync_with_ring = true },
	},
	keys = {
		-- Yank with ring capture
		{ "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank" },

		-- Paste with ring capture (so cycling works after)
		{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put after" },
		{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put before" },
		{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put after (cursor moves)" },
		{ "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put before (cursor moves)" },

		-- Cycle through ring after paste
		{ "<C-n>", "<Plug>(YankyCycleForward)", desc = "Cycle yank forward" },
		{ "<C-p>", "<Plug>(YankyCycleBackward)", desc = "Cycle yank backward" },

		-- History picker
		{ "<leader>p", "<cmd>YankyRingHistory<cr>", desc = "[P]aste from yank history" },

		-- Indent-aware put
		{ "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after" },
		{ "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before" },
	},
}
