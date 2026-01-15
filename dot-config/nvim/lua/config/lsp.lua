require("mason").setup()
require("mason-lspconfig").setup({
    -- names from 
    -- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
    ensure_installed = {
	-- "apex_ls",
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
	"pylsp", --python
	"rust_analyzer",
	"tombi", --toml
	"ts_ls",
	"visualforce_ls",
	"vue_ls",
	"yamlls",
	"zls" --zig
    }
})

vim.diagnostic.config({
  virtual_text = true,
})



