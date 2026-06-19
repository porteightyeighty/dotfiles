return {
	"chrisgrieser/nvim-spider",
	keys = {
		{ "w",  function()
			local pos = vim.api.nvim_win_get_cursor(0)
			require("spider").motion("w")
			-- spider returns early at EOF without moving; fall back to native w
			if vim.deep_equal(pos, vim.api.nvim_win_get_cursor(0)) then
				vim.cmd.normal { "w", bang = true }
			end
		end, mode = { "n", "x", "o" }, desc = "Spider-w" },
		{ "e",  function() require("spider").motion("e") end,  mode = { "n", "x", "o" }, desc = "Spider-e" },
		{ "b",  function() require("spider").motion("b") end,  mode = { "n", "x", "o" }, desc = "Spider-b" },
		{ "ge", function() require("spider").motion("ge") end, mode = { "n", "x", "o" }, desc = "Spider-ge" },
	},
	opts = {
		skipInsignificantPunctuation = false,
	},
}
