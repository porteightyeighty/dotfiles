# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration using lazy.nvim for plugin management. It's a Java-focused development environment with strong LSP integration, debugging support, and modern tooling.

## Architecture

### Entry Point
`init.lua` - Sets vim options, basic keymaps, leader key (`<Space>`), and requires config modules in order: `java`, `lazy`, `mappings`, `lsp`.

### Configuration Structure
```
lua/
├── config/           # Core configuration modules
│   ├── lazy.lua      # Lazy.nvim bootstrap
│   ├── lsp.lua       # LSP server setup (mason + mason-lspconfig)
│   ├── mappings.lua  # All plugin keybindings
│   ├── java.lua      # :JavaNewProject scaffolding command
│   └── templates/    # Maven project templates
└── plugins/          # Lazy.nvim plugin specs (one file per plugin)
    └── lsp/          # Language-specific LSP configs
```

### Plugin Organization
Each plugin is a separate Lua file in `lua/plugins/` returning a lazy.nvim spec table. Plugins declare their own dependencies, lazy-loading triggers (event/ft/keys), and configuration.

### Key Subsystems
- **LSP**: `lua/config/lsp.lua` handles general servers; `lua/plugins/jdtls.lua` handles Java separately with extensive configuration
- **Completion**: blink.cmp (Rust-based completion engine)
- **Debugging**: nvim-dap with dap-ui, Java debug adapter configured in jdtls.lua
- **Formatting**: conform.nvim with LSP fallback

## Keymap Conventions

Leader-based groups defined in `lua/config/mappings.lua`:
- `<leader>s` - Search (Telescope)
- `<leader>d` - Debug (DAP)
- `<leader>j` - Java (jdtls)
- `<leader>r` - Refactor
- `<leader>c` - Code actions
- `<leader>w` - Workspace (LSP)
- `\` - Oil file browser

## Adding New Plugins

Create a new file in `lua/plugins/` returning a lazy.nvim spec:
```lua
return {
  'author/plugin-name',
  event = 'VeryLazy',  -- or ft, keys, etc.
  opts = {},
  config = function()
    -- setup code
  end,
}
```

## Testing Changes

Restart Neovim or run `:Lazy reload <plugin>`. Use `:checkhealth` to diagnose issues. Use `:Lazy` to manage plugins.
