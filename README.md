# porteightyeighty Dotfiles

A reproducible macOS environment driven by a **Nix flake + [home-manager](https://github.com/nix-community/home-manager)**.

It's a **hybrid** setup:

- **Native home-manager modules** for simple/standalone tools (`git`, `tmux`).
- **Symlinked configs** for everything that's edited often (`nvim`, `yazi`,
  `starship`, `wezterm`, `alacritty`, `zsh`). These are out-of-store symlinks back
  into this repo, so edits take effect immediately — no rebuild required.
- CLI tools come from nix (`home.packages`); language runtimes stay on their own
  managers (`nvm`, `rbenv`, `sdkman`); GUI apps stay on Homebrew casks.

The config is **portable across accounts**: the running user is read from `$USER`
at build time, so the same flake works for any login on any machine without
enumerating usernames. (This is why switches use `--impure`.) Git identity is kept
out of the repo — each account provides its own untracked
`~/.config/git/config.local`.

## Prerequisites

- [Determinate Nix](https://docs.determinate.systems/) (or any Nix with flakes enabled)
- `git`

Everything else is provided by the flake.

## Getting started (new account / machine)

```bash
# 1. Clone into your home folder
git clone <this-repo> ~/dotfiles

# 2. Set your git identity (untracked — never committed)
mkdir -p ~/.config/git
cat > ~/.config/git/config.local <<'EOF'
[user]
	name = Your Name
	email = you@example.com
EOF

# 3. First build + activate (-b backup renames any colliding plain files)
nix run home-manager/master -- switch --flake ~/dotfiles#default --impure -b backup
```

Open a fresh shell and confirm tools resolve into the nix profile, e.g.
`command -v rg` → `~/.nix-profile/bin/rg`.

## Tools outside nix

Runtimes and self-updating CLIs aren't nix packages. After the switch above:

- **nvm** — auto-installed by the `zsh-nvm` zinit plugin on first shell start; then `nvm install --lts`.
- **sdkman** (Java/Maven only) — `curl -s "https://get.sdkman.io" | bash`.
- **Salesforce CLI (`sf`)** — official macOS installer ([docs](https://developer.salesforce.com/tools/salesforcecli)):
  ```bash
  curl -fsSL https://developer.salesforce.com/media/salesforce-cli/sf/channels/stable/sf-arm64.pkg -o /tmp/sf.pkg
  sudo installer -pkg /tmp/sf.pkg -target /
  ```

## Day-to-day

After editing `flake.nix` / `home.nix`, re-activate with the alias:

```bash
hms   # = home-manager switch --flake ~/dotfiles#default --impure
```

Symlinked configs (nvim, yazi, zsh, …) are live — just edit the files in this repo,
no `hms` needed.

## Notes

- **Migrating from a stow-managed setup?** Remove the old symlinks first
  (`stow -D -t ~ .`) so home-manager can take over, then run the first switch above.
- **Homebrew** is still used for GUI casks (`ghostty`, `raycast`, `hiddenbar`) and
  runtime/service formulae you choose to keep. CLI formulae that nix now provides
  can be uninstalled by whichever account owns Homebrew.
- **Neovim LSPs/formatters** are managed by Mason inside nvim, not nix.
- `--impure` is required on every switch because the username is read from the
  environment.
