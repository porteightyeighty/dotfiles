require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
-- LSP needs blink.cmp + mason, which only load in the full profile.
if (vim.g.profile or "full") == "full" then
	require("config.lsp")
end
