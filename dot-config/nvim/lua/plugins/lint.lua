return {
	"mfussenegger/nvim-lint",
	event = { "BufWritePost", "InsertLeave", "BufReadPost" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			apex = { "pmd" },
			java = { "checkstyle" },
		}

		-- checkstyle ships google_checks.xml / sun_checks.xml inside its jar.
		-- Point it at one of those, or swap for a project-local checkstyle.xml.
		lint.linters.checkstyle.config_file = "/google_checks.xml"
		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufReadPost" }, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
