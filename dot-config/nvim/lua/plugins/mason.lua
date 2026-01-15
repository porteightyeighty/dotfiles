return {
    {"mason-org/mason.nvim", opts = {}},
    {"mason-org/mason-lspconfig.nvim", opts = {}},
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

