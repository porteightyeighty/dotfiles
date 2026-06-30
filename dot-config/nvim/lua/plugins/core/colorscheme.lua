return {
	"rose-pine/neovim",
	name = "rose-pine",
	priority = 1000,
	lazy = false,
	config = function()
		require("rose-pine").setup({})

		-- Edit these to change the toggle pair
		local dark = "rose-pine-main"
		local light = "rose-pine-dawn"

		vim.cmd.colorscheme(dark)

		vim.keymap.set("n", "<leader>tt", function()
			vim.cmd.colorscheme(vim.o.background == "light" and dark or light)
		end, { desc = "[T]oggle [t]heme light/dark" })
	end,
}
