return {
	"AndrewRadev/linediff.vim",
	cmd = { "Linediff", "LinediffReset", "LinediffAdd", "LinediffShow", "LinediffMerge", "LinediffPick" },
	keys = {
		-- Visual mode: select region A → trigger, select region B → trigger again to diff.
		-- Plain `:` (not <cmd>) so the visual range '<,'> is passed to the command.
		{ "<leader>Dl", ":Linediff<CR>", mode = "x", desc = "Linediff selection" },
		{ "<leader>Da", ":LinediffAdd<CR>", mode = "x", desc = "Linediff add block (3+)" },
		{ "<leader>Ds", "<cmd>LinediffShow<CR>", desc = "Linediff show buffered blocks" },
		{ "<leader>Dr", "<cmd>LinediffReset<CR>", desc = "Linediff reset" },
	},
}
