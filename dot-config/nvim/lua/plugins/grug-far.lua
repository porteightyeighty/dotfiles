return {
	"MagicDuck/grug-far.nvim",
	cmd = { "GrugFar", "GrugFarWithin" },
	opts = {},
	keys = {
		{ "<leader>sR", function() require("grug-far").open() end, desc = "[S]earch & [R]eplace (project)" },
		{ "<leader>sR", mode = "v", function() require("grug-far").with_visual_selection() end, desc = "[S]earch & [R]eplace (selection)" },
	},
}
