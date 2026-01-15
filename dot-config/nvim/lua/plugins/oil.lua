-- Helper for winbar to show ~ instead of full home path
local function get_oil_winbar()
	local oil = require('oil')
	local dir = oil.get_current_dir()
	if dir then
		return dir:gsub('^' .. vim.env.HOME, '~')
	end
	return ''
end

-- Expose globally for v:lua access in winbar
_G.get_oil_winbar = get_oil_winbar

-- Drill down through directories that only contain a single subdirectory
local function get_deepest_dir(path)
	local entries = vim.fn.readdir(path)
	-- Filter out hidden files if oil is configured to hide them (default behavior)
	entries = vim.tbl_filter(function(e)
		return not vim.startswith(e, '.')
	end, entries)

	if #entries == 1 then
		local child_path = path .. '/' .. entries[1]
		if vim.fn.isdirectory(child_path) == 1 then
			return get_deepest_dir(child_path)
		end
	end
	return path
end

local function open_with_drill_down()
	local oil = require('oil')
	local entry = oil.get_cursor_entry()

	if entry and entry.type == 'directory' then
		local dir = oil.get_current_dir()
		if dir then
			local target = dir .. entry.name
			local deepest = get_deepest_dir(target)
			oil.open(deepest)
			return
		end
	end
	-- Default behavior for files or if something went wrong
	oil.select()
end

return {
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		watch_for_changes = true,
		skip_confirm_for_simple_edits = false,
		win_options = {
			winbar = "%{v:lua.get_oil_winbar()}",
		},
		keymaps = {
			['<CR>'] = { callback = open_with_drill_down, desc = 'Open with drill-down' },
			['<C-l>'] = false,
		},
	},
	-- Optional dependencies
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
}
