return {
	"kevalin/mermaid.nvim",
	ft = { "mermaid" },
	cmd = { "MermaidPreview", "MermaidFormat" },
	opts = {},
	config = function()
		require("mermaid").setup()
		vim.keymap.set("n", "<leader>mp", "<cmd>MermaidPreview<CR>", { buffer = buf, desc = "Mermaid Preview" })
		vim.keymap.set("n", "<leader>mf", "<cmd>MermaidFormat<CR>", { buffer = buf, desc = "Mermaid Format" })
	end,
}
