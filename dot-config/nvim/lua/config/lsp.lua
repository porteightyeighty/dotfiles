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

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
		end

		-- Navigation
		map("n", "gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		map("n", "gr", vim.lsp.buf.references, "[G]oto [R]eferences")
		map("n", "gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
		map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- Documentation
		map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
		map("n", "<C-K>", vim.lsp.buf.signature_help, "Signature Help")

		-- Rename
		map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

		-- Code actions
		map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("n", "<leader>cw", vim.lsp.buf.workspace_symbol, "[C]ode [W]orkspace Symbols")

		-- Inlay hints
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
			map("n", "<leader>ch", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
			end, "[C]ode Inlay [H]ints Toggle")
		end
	end,
})
