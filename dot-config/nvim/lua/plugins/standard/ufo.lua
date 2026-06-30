return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{ "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
		{ "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
		{ "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Fold less" },
		{ "zm", function() require("ufo").closeFoldsWith() end, desc = "Fold more" },
		{
			"zp",
			function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end,
			desc = "Peek fold or hover",
		},
	},
	init = function()
		vim.o.foldcolumn = "1"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
	end,
	opts = {
		provider_selector = function(_, filetype, _)
			local lsp_only = { python = true, rust = true, go = true, typescript = true, javascript = true, lua = true }
			if lsp_only[filetype] then
				return { "lsp", "treesitter" }
			end
			return { "treesitter", "indent" }
		end,
	},
}
