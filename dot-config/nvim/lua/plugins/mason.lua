return {
    {"mason-org/mason.nvim", opts = {}},
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "saghen/blink.cmp" },
        opts = {
            handlers = {
                function(server_name)
                    local capabilities = require('blink.cmp').get_lsp_capabilities()
                    require('lspconfig')[server_name].setup({ capabilities = capabilities })
                end,
            },
        },
    },
    {"neovim/nvim-lspconfig" },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "mason-org/mason.nvim" },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- Java development
                    "jdtls",
                    "java-debug-adapter",
                    "java-test",
                    "google-java-format",
                },
                auto_update = false,
                run_on_start = true,
            })
        end,
    },
}

