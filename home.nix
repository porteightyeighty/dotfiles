{ pkgs, config, ... }:

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

  # Symlinked configs -> point at the working tree (live edits, no rebuild)
  home.file.".zshrc".source = link "dot-zshrc";
  home.file.".wezterm.lua".source = link "dot-wezterm.lua";
  home.file.".local/bin/starship-sf-org".source = link "dot-local/bin/starship-sf-org";
  home.file.".gitignore_global".source = link "dot-gitignore_global";

  xdg.configFile."nvim".source = link "dot-config/nvim";
  xdg.configFile."starship.toml".source = link "dot-config/starship.toml";
  xdg.configFile."alacritty".source = link "dot-config/alacritty";
  xdg.configFile."yazi".source = link "dot-config/yazi";
}
