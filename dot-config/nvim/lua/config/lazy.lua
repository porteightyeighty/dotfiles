-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Profile (minimal | standard | full) chosen via `nvim --cmd 'lua vim.g.profile=...'`.
-- core always loads; standard adds editing/nav QoL; full adds language tooling.
local profile = vim.g.profile or "full"
local spec = { { import = "plugins.core" } }
if profile ~= "minimal" then
	table.insert(spec, { import = "plugins.standard" })
end
if profile == "full" then
	table.insert(spec, { import = "plugins.full" })
end

-- Setup lazy.nvim
require("lazy").setup({
	spec = spec,
	-- Configure any other settings here. See the documentation for more details.
	-- automatically check for plugin updates
	checker = { enabled = true },
})
