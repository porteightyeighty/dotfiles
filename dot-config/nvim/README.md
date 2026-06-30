# Neovim config

Lazy.nvim-based config, symlinked into `~/.config/nvim` by home-manager
(`xdg.configFile."nvim"` in `home.nix`). Leader is `<Space>`.

## Profiles

The config loads in one of three tiers, selected at launch via `vim.g.profile`
(read in `lua/config/lazy.lua`). A zsh wrapper in `dot-zshrc` picks the tier:

| Command          | Profile    | Loads                                                  |
| ---------------- | ---------- | ------------------------------------------------------ |
| `nvim`           | `full`     | everything (default)                                   |
| `nvim std FILE`  | `standard` | core + editing/navigation QoL, no language tooling     |
| `nvim min FILE`  | `minimal`  | core only (colorscheme + treesitter)                   |

Under the hood the wrapper just passes `--cmd 'lua vim.g.profile="..."'`.
LSP (`config.lsp`) only loads in `full`.

## Layout

```
init.lua              entry point
lua/config/           settings, always loaded for every profile
  options · keymaps · autocmds · lsp · servers · lazy
lua/plugins/
  core/               loads in all profiles
  standard/           loads in standard + full
  full/               loads in full only (LSP, completion, DAP, language tooling)
```

Settings live entirely in `lua/config/`, so they are shared across all
profiles by construction. Profiles only change *which plugins* load, never the
settings. To move a plugin between tiers, just move its file between the
`core/` / `standard/` / `full/` directories.

## Common tasks

- Apply zsh/home-manager changes: `hms`
- Update/prune plugins: `:Lazy sync`
