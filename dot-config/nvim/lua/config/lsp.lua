local servers = require("config.servers")

vim.lsp.config("*", {
	before_init = function(params)
		params.capabilities = require("blink.cmp").get_lsp_capabilities()
	end,
})

-- Prevent html LSP from attaching to Aura component files (lwc_ls handles those)
vim.lsp.config("html", {
	root_dir = function(bufnr, on_dir)
		local path = vim.api.nvim_buf_get_name(bufnr)
		if path:find("/lwc/", 1, true) then
			return
		end
		on_dir(vim.fn.getcwd())
	end,
})

-- Apex LSP needs custom args (jar path, heap size) beyond the shared default
vim.lsp.config("apex_ls", {
	apex_jar_path = vim.fn.stdpath("data") .. "/mason/share/apex-language-server/apex-jorje-lsp.jar",
	apex_enable_semantic_errors = true,
	apex_jvm_max_heap = "4096m",
	filetypes = { "apex", "apexcode", "trigger" },
})

local lsp_names = vim.tbl_keys(servers)
vim.lsp.enable(lsp_names)

vim.diagnostic.config({
	virtual_text = true,
})
