return {
	"chrisgrieser/nvim-spider",
	keys = {
		{ "w",  function() require("spider").motion("w") end,  mode = { "n", "x", "o" }, desc = "Spider-w" },
		{ "e",  function() require("spider").motion("e") end,  mode = { "n", "x", "o" }, desc = "Spider-e" },
		{ "b",  function() require("spider").motion("b") end,  mode = { "n", "x", "o" }, desc = "Spider-b" },
		{ "ge", function() require("spider").motion("ge") end, mode = { "n", "x", "o" }, desc = "Spider-ge" },
	},
	opts = {
		skipInsignificantPunctuation = false,
	},
}
