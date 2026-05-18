return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	keys = {
		{ "<leader>cr", function() require("refactoring").select_refactor() end, mode = { "n", "x" }, desc = "[C]ode [R]efactor picker" },
		{ "<leader>ce", function() require("refactoring").refactor("Extract Function") end, mode = "x", desc = "[C]ode [E]xtract function" },
		{ "<leader>cE", function() require("refactoring").refactor("Extract Function To File") end, mode = "x", desc = "[C]ode [E]xtract function to file" },
		{ "<leader>cv", function() require("refactoring").refactor("Extract Variable") end, mode = "x", desc = "[C]ode extract [V]ariable" },
		{ "<leader>cV", function() require("refactoring").refactor("Inline Variable") end, mode = { "n", "x" }, desc = "[C]ode inline [V]ariable" },
		{ "<leader>ci", function() require("refactoring").refactor("Inline Function") end, mode = "n", desc = "[C]ode [I]nline function" },

		-- Debug-print helpers
		{ "<leader>cdv", function() require("refactoring").debug.print_var() end, mode = { "n", "x" }, desc = "Debug: print [V]ariable" },
		{ "<leader>cdf", function() require("refactoring").debug.printf({ below = true }) end, mode = "n", desc = "Debug: print [F]unction entry" },
		{ "<leader>cdc", function() require("refactoring").debug.cleanup({}) end, mode = "n", desc = "Debug: [C]leanup print statements" },
	},
	opts = {},
}
