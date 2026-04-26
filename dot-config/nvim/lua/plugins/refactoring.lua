return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{ "<leader>re", function() return require("refactoring").refactor("Extract Function") end, mode = { "n", "x" }, expr = true, desc = "[R]efactor: [E]xtract" },
		{ "<leader>rf", function() return require("refactoring").refactor("Extract Function To File") end, mode = { "n", "x" }, expr = true, desc = "[R]efactor: Extract to [F]ile" },
		{ "<leader>rv", function() return require("refactoring").refactor("Extract Variable") end, mode = { "n", "x" }, expr = true, desc = "[R]efactor: Extract [V]ariable" },
		{ "<leader>rI", function() return require("refactoring").refactor("Inline Function") end, mode = { "n", "x" }, expr = true, desc = "[R]efactor: [I]nline Function" },
		{ "<leader>ri", function() return require("refactoring").refactor("Inline Variable") end, mode = { "n", "x" }, expr = true, desc = "[R]efactor: [I]nline Variable" },
		{ "<leader>rb", function() return require("refactoring").refactor("Extract Block") end, mode = { "n", "x" }, expr = true, desc = "[R]efactor: Extract [B]lock" },
		{ "<leader>rB", function() return require("refactoring").refactor("Extract Block To File") end, mode = { "n", "x" }, expr = true, desc = "[R]efactor: Extract [B]lock to File" },
		{ "<leader>rpf", function() require("refactoring").debug.printf({ below = false }) end, desc = "[R]efactor: Print Var" },
		{ "<leader>rpv", function() require("refactoring").debug.print_var() end, mode = { "x", "n" }, desc = "[R]efactor: Print Var" },
		{ "<leader>rc", function() require("refactoring").debug.cleanup({}) end, desc = "[R]efactor: [C]leanup" },
	},
	opts = {},
}
