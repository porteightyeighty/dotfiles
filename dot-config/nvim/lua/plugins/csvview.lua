return {
	"hat0uma/csvview.nvim",
	ft = { "csv", "tsv" },
	cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	opts = {
		view = {
			display_mode = "border",
		},
	},
	config = function(_, opts)
		require("csvview").setup(opts)
		-- Auto-enable on CSV/TSV buffers
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "csv", "tsv" },
			callback = function()
				vim.cmd("CsvViewEnable")
			end,
		})
	end,
}
