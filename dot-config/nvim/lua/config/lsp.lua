require("mason").setup()
require("mason-lspconfig").setup({
    -- names from 
    -- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
    ensure_installed = {
	"bashls",
	"clangd",
	"cssls",
	"css_variables",
	"cssmodules_ls",
	"html",
	"jsonls",
	"lua_ls",
	"lwc_ls",
	"marksman", --markdown
	"nginx_language_server",
	"pyright", --python
	"rust_analyzer",
	"tombi", --toml
	"ts_ls",
	"visualforce_ls",
	"vue_ls",
	"yamlls",
	"zls" --zig
    }
})

-- Apex LSP (installed via mason-tool-installer, not mason-lspconfig)
vim.lsp.config('apex_ls', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
    apex_jar_path = vim.fn.stdpath("data") .. "/mason/share/apex-language-server/apex-jorje-lsp.jar",
    apex_enable_semantic_errors = true,
    filetypes = { "apex", "apexcode", "trigger" },
})
vim.lsp.enable('apex_ls')

vim.diagnostic.config({
  virtual_text = true,
})



