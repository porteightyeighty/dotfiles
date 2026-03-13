return {
	"mfussenegger/nvim-lint",
	event = { "BufWritePost", "InsertLeave", "BufReadPost" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			apex = { "pmd" },
		}
		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufReadPost" }, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
