return {
	"b0o/incline.nvim",
	dependencies = { "echasnovski/mini.nvim" },
	event = "VeryLazy",
	config = function()
		require("incline").setup({
			window = {
				padding = 0,
				margin = { horizontal = 0, vertical = 0 },
			},
			hide = {
				cursorline = true,
			},
			render = function(props)
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
				if filename == "" then
					filename = "[No Name]"
				end
				local icon, color = require("mini.icons").get("file", filename)
				local modified = vim.bo[props.buf].modified

				return {
					{ " " },
					{ icon or "", group = color },
					{ " " },
					{ filename, gui = modified and "bold,italic" or "bold" },
					{ modified and " ●" or "" },
					{ " " },
				}
			end,
		})
	end,
}
