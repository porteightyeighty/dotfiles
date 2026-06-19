return {
	"kevalin/mermaid.nvim",
	ft = { "mermaid" },
	cmd = { "MermaidPreview" },
	config = function()
		require("mermaid").setup({
			preview = {
				theme = "forest",
			},
		})
		vim.keymap.set("n", "<leader>mp", "<cmd>MermaidPreview<CR>", { desc = "Mermaid browser preview" })
	end,
}
