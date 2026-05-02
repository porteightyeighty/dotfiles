return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	opts = {
		options = {
			theme = "auto",
		},
		sections = {
			lualine_c = { "filename" },
			lualine_x = {
				{
					function()
						local sf_ok, sf = pcall(require, "sf")
						if sf_ok and sf.get_target_org then
							local org = sf.get_target_org()
							if org and org ~= "" then
								return "SF: " .. org
							end
						end
						return ""
					end,
					cond = function()
						return vim.fn.findfile("sfdx-project.json", ".;") ~= ""
					end,
				},
				"filetype",
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_c = { "filename" },
			lualine_x = {
				{
					function()
						local sf_ok, sf = pcall(require, "sf")
						if sf_ok and sf.get_target_org then
							local org = sf.get_target_org()
							if org and org ~= "" then
								return "SF: " .. org
							end
						end
						return ""
					end,
					cond = function()
						return vim.fn.findfile("sfdx-project.json", ".;") ~= ""
					end,
				},
				"filetype",
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}
