return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("harpoon"):setup()
	end,
	keys = function()
		local keys = {
			{
				"<leader>zc",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Harpoon add file",
			},
			{
				"<leader><leader>",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Harpoon quick menu",
			},
			{
				"<leader>zb",
				function()
					require("harpoon"):list():prev()
				end,
				desc = "Harpoon prev",
			},
			{
				"<leader>zn",
				function()
					require("harpoon"):list():next()
				end,
				desc = "Harpoon next",
			},
		}
		for i = 1, 5 do
			table.insert(keys, {
				"<leader>z" .. i,
				function()
					require("harpoon"):list():select(i)
				end,
				desc = "Harpoon select " .. i,
			})
		end
		return keys
	end,
}
