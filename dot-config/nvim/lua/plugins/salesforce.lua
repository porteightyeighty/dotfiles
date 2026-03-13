return {
	"xixiaofinland/sf.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "ibhagwan/fzf-lua" },
	ft = { "apex", "sosl", "soql", "javascript", "html" },
	cmd = { "SF" },
	opts = {
		enable_hotkeys = false,
	},
	keys = {
		{ "<leader>Ss", "<cmd>SF org setTarget<CR>", desc = "Set target org" },
		{ "<leader>Sf", "<cmd>SF org fetchList<CR>", desc = "Fetch org list" },
		{ "<leader>Sp", "<cmd>SF currentFile push<CR>", desc = "Push current file" },
		{ "<leader>Sr", "<cmd>SF currentFile retrieve<CR>", desc = "Retrieve current file" },
		{ "<leader>Sd", "<cmd>SF currentFile diff<CR>", desc = "Diff in target org" },
		{ "<leader>St", "<cmd>SF test currentTest<CR>", desc = "Run test at cursor" },
		{ "<leader>ST", "<cmd>SF test allTestsInThisFile<CR>", desc = "Run all tests in file" },
		{ "<leader>Sa", "<cmd>SF test allTestsInOrg<CR>", desc = "Run all local tests" },
		{ "<leader>Sc", "<cmd>SF create ctags<CR>", desc = "Create ctags index" },
		{ "<leader>Sl", "<cmd>SF md list<CR>", desc = "List metadata" },
		{ "<leader>Sm", "<cmd>SF md pull<CR>", desc = "Pull metadata" },
		{ "<leader>So", "<cmd>SF org open<CR>", desc = "Open org in browser" },
		-- { "<leader>S<Space>", "<cmd>SF term toggle<CR>", desc = "Toggle SF terminal" },
	},
}
