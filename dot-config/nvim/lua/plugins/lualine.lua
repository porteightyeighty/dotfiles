return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "dracula",
		},
		sections = {
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
				"encoding",
				"fileformat",
				"filetype",
			},
		},
	},
}
