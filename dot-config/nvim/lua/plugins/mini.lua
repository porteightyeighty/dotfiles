return {
	"nvim-mini/mini.nvim",
	version = false,
	event = "VeryLazy",
	config = function()
		require("mini.ai").setup({})
		require("mini.bracketed").setup({})
		require("mini.diff").setup({})
		local miniclue = require("mini.clue")
		miniclue.setup({
			triggers = {
				-- Leader triggers
				{ mode = { "n", "x" }, keys = "<Leader>" },
				-- `[` and `]` keys
				{ mode = "n", keys = "[" },
				{ mode = "n", keys = "]" },
				-- Built-in completion
				{ mode = "i", keys = "<C-x>" },
				-- `g` key
				{ mode = { "n", "x" }, keys = "g" },
				-- Marks
				{ mode = { "n", "x" }, keys = "'" },
				{ mode = { "n", "x" }, keys = "`" },
				-- Registers
				{ mode = { "n", "x" }, keys = '"' },
				{ mode = { "i", "c" }, keys = "<C-r>" },
				-- Window commands
				{ mode = "n", keys = "<C-w>" },
				-- `z` key
				{ mode = { "n", "x" }, keys = "z" },
			},

			window = {
				delay = 200,
				config = {
					width = "auto",
				},
			},
			clues = {
				miniclue.gen_clues.square_brackets(),
				miniclue.gen_clues.builtin_completion(),
				miniclue.gen_clues.g(),
				miniclue.gen_clues.marks(),
				miniclue.gen_clues.registers(),
				miniclue.gen_clues.windows(),
				miniclue.gen_clues.z(),

				-- Leader group descriptions
				{ mode = "n", keys = "<Leader>c", desc = "+Code" },
				{ mode = "x", keys = "<Leader>c", desc = "+Code" },
				{ mode = "n", keys = "<Leader>d", desc = "+Debug" },
				{ mode = "n", keys = "<Leader>s", desc = "+Search" },
				{ mode = "n", keys = "<Leader>w", desc = "+Window" },
				{ mode = "n", keys = "<Leader>S", desc = "+Salesforce" },
				{ mode = "n", keys = "<Leader>Sn", desc = "+New" },
				{ mode = "n", keys = "<Leader>z", desc = "+Harpoon" },
			},
		})
		-- require('mini.cmdline').setup({})
		require("mini.icons").setup({})
		require("mini.jump").setup({})
		require("mini.jump2d").setup({})
		require("mini.pairs").setup({})
		local gen_loader = require("mini.snippets").gen_loader
		require("mini.snippets").setup({
			snippets = {
				-- Load language-matched snippets from friendly-snippets (on runtimepath)
				gen_loader.from_runtime("snippets"),
				-- Load user snippets from ~/.config/nvim/snippets/{lang}.json
				gen_loader.from_lang(),
			},
		})
		require("mini.surround").setup({})
	end,
}
