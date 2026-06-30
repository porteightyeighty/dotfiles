return {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	config = function()
		local mason_share = vim.fn.stdpath("data") .. "/mason/share"
		local bundles = vim.fn.glob(
			mason_share .. "/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar",
			true,
			true
		)
		vim.list_extend(bundles, vim.fn.glob(mason_share .. "/java-test/*.jar", true, true))

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = function()
				local root = vim.fs.root(0, { "gradlew", "mvnw", "pom.xml", "build.gradle", ".git" })
					or vim.fn.getcwd()
				local workspace = vim.fn.stdpath("cache") .. "/jdtls-workspaces/" .. vim.fn.fnamemodify(root, ":t")

				require("jdtls").start_or_attach({
					cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls", "-data", workspace },
					root_dir = root,
					capabilities = require("blink.cmp").get_lsp_capabilities(),
					init_options = { bundles = bundles },
					settings = {
						java = {
							signatureHelp = { enabled = true, description = { enabled = true } },
							configuration = {
								runtimes = {},
							},
						},
					},
				})
			end,
		})
	end,
}
