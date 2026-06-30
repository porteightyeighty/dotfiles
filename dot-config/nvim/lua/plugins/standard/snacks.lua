return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "[S]earch [H]elp",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "[S]earch [C]olorscheme (live preview)",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "[S]earch [K]eymaps",
		},
		{
			"<leader>sf",
			function()
				Snacks.picker.files()
			end,
			desc = "[S]earch [F]iles",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.pickers()
			end,
			desc = "[S]earch [S]elect Picker",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "[S]earch current [W]ord",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "[S]earch by [G]rep",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "[S]earch [D]iagnostics",
		},
		{
			"<leader>sr",
			function()
				Snacks.picker.resume()
			end,
			desc = "[S]earch [R]esume",
		},
		{
			"<leader>s.",
			function()
				Snacks.picker.recent()
			end,
			desc = '[S]earch Recent Files ("." for repeat)',
		},
		{
			"<leader>sn",
			function()
				Snacks.picker.grep({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "[S]earch [N]eovim Files",
		},
		{
			"<leader><leader>",
			function()
				Snacks.picker.buffers()
			end,
			desc = "[S]earch existing buffers",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.lines()
			end,
			desc = "[/] Fuzzy Find in Buffer",
		},
		{
			"<leader>nh",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "[N]otification [H]istory",
		},
		{
			"\\",
			function()
				Snacks.explorer.open()
			end,
		},
	},
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		explorer = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true },
		picker = {
			enabled = true,
			sources = {
				explorer = { auto_close = false, git_status_open = true, jump = { close = true } },
			},
		},
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		dashboard = {
			enabled = true,
			width = 70,
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{
					pane = 2,
					icon = " ",
					title = "Recent Files",
					section = "recent_files",
					indent = 2,
					padding = 1,
				},
				{
					pane = 2,
					icon = " ",
					title = "Projects",
					section = "projects",
					indent = 2,
					padding = 1,
				},
				{
					pane = 2,
					icon = " ",
					title = "Git Status",
					section = "terminal",
					enabled = function()
						return Snacks.git.get_root() ~= nil
					end,
					cmd = "git status --short --branch --renames",
					height = 5,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
				},
				{ section = "startup" },
			},
			preset = {
				-- 		header = [[
				-- ███╗   ██╗██╗   ██╗██╗███╗   ███╗
				-- ████╗  ██║██║   ██║██║████╗ ████║
				-- ██╔██╗ ██║██║   ██║██║██╔████╔██║
				-- ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
				-- ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
				-- ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
				header = [[
  ██████   █████                   █████   █████  ███                  
 ░░██████ ░░███                   ░░███   ░░███  ░░░                   
  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   
  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  
  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  
  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  
  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ 
 ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
				keys = {
					{
						icon = " ",
						key = "s",
						desc = "Restore Session",
						action = ":lua require('persistence').load()",
					},
					{
						icon = " ",
						key = "p",
						desc = "Projects",
						action = ":lua Snacks.picker.projects()",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.picker.recent()",
					},
					{
						icon = " ",
						key = "f",
						desc = "Find File",
						action = ":lua Snacks.picker.files()",
					},
					{
						icon = " ",
						key = "n",
						desc = "New File",
						action = ":ene | startinsert",
					},
					{
						icon = "󰒲 ",
						key = "l",
						desc = "Lazy",
						action = ":Lazy",
					},
					{
						icon = " ",
						key = "q",
						desc = "Quit",
						action = ":qa",
					},
				},
			},
		},
	},
}
