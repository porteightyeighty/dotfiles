return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require("nvim-treesitter").install({
      "apex",
      "bash",
      "c",
      "css",
      "html",
      "java",
      "javascript",
      "json",
      "lua",
      "markdown",
      "python",
      "rust",
      "sflog",
      "soql",
      "sosl",
      "sql",
      "tmux",
      "toml",
      "typescript",
      "vim",
      "vimdoc",
      "vue",
      "xml",
      "yaml",
      "zig",
      "zsh",
    })

    -- Enable treesitter highlighting for parsers that don't ship with Neovim
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "apex", "soql", "sosl", "sflog" },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
