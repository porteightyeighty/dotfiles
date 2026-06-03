{ pkgs, config, lib, ... }:

let
  # The dotfiles working tree. Configs are symlinked back here (out-of-store) so
  # live edits take effect without a home-manager rebuild.
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
  # home.username + home.homeDirectory are injected per-account by flake.nix.
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Shell / UX
    ripgrep
    fd
    fzf
    zoxide
    starship
    yazi
    jq
    tree
    tldr
    wget

    # Git / dev
    lazygit
    gh
    universal-ctags
    neovim
    tree-sitter

    # Apex lint
    pmd

    # Yazi preview deps
    poppler-utils # PDF
    ffmpeg-full   # video thumbnails
    resvg         # SVG
    _7zz          # archive preview (7zz)
    imagemagick   # broad image formats (HEIC etc.)

    # Fonts
    nerd-fonts.monaspace
  ];

  # Native module: git. Identity is deliberately kept OUT of the repo: each
  # account supplies its own untracked ~/.config/git/config.local with a [user]
  # block. Everything shared (excludes, etc.) lives here.
  programs.git = {
    enable = true;
    settings.core.excludesFile = "${config.home.homeDirectory}/.gitignore_global";
    includes = [ { path = "${config.home.homeDirectory}/.config/git/config.local"; } ];
  };

  # Native module: tmux (replaces tpm + dot-tmux.conf)
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    plugins = with pkgs.tmuxPlugins; [ sensible vim-tmux-navigator ];
  };

  # Native module: zsh. home-manager installs zsh from nixpkgs and generates
  # ~/.zshrc; we keep the live-edit workflow by having that generated file
  # `source` the working-tree dot-zshrc (read at shell startup, so edits take
  # effect immediately without a rebuild).
  programs.zsh = {
    enable = true;
    initContent = "source ${dotfiles}/dot-zshrc";
  };

  # Make the nix-installed zsh the login shell. Standalone home-manager can't
  # manage /etc/passwd declaratively, so this activation script does it at
  # switch time: allowlist the binary in /etc/shells (needs sudo) then chsh.
  # Fully idempotent — a no-op once the login shell already matches.
  home.activation.setDefaultShell =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ZSH="${config.programs.zsh.package}/bin/zsh"
      # Home Manager's activation PATH holds only nix store paths (coreutils etc.),
      # not /usr/bin — so reference system tools by absolute path and parse dscl's
      # output with the shell instead of awk.
      if [ "$(uname)" = "Darwin" ]; then
        CURRENT="$(/usr/bin/dscl . -read "/Users/$USER" UserShell 2>/dev/null)"
        CURRENT="''${CURRENT#UserShell: }"
        chsh=/usr/bin/chsh
        sudo=/usr/bin/sudo
      else
        CURRENT="$(getent passwd "$USER" 2>/dev/null | cut -d: -f7)"
        chsh=chsh
        sudo=sudo
      fi
      if [ "$CURRENT" != "$ZSH" ]; then
        if ! ${pkgs.gnugrep}/bin/grep -qxF "$ZSH" /etc/shells; then
          echo "Adding $ZSH to /etc/shells (sudo)…"
          echo "$ZSH" | "$sudo" tee -a /etc/shells >/dev/null
        fi
        echo "Setting login shell to $ZSH (chsh)…"
        "$chsh" -s "$ZSH" || echo "chsh failed — run: $chsh -s $ZSH"
      fi
    '';

  # Symlinked configs -> point at the working tree (live edits, no rebuild)
  home.file.".wezterm.lua".source = link "dot-wezterm.lua";
  home.file.".local/bin/starship-sf-org".source = link "dot-local/bin/starship-sf-org";
  home.file.".gitignore_global".source = link "dot-gitignore_global";

  xdg.configFile."nvim".source = link "dot-config/nvim";
  xdg.configFile."starship.toml".source = link "dot-config/starship.toml";
  xdg.configFile."alacritty".source = link "dot-config/alacritty";
  xdg.configFile."yazi".source = link "dot-config/yazi";
}
