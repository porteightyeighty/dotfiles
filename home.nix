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
    yazi
    jq
    tree
    tldr
    wget
    openssl 
    curl
    bat
    jless

    # Git / dev
    lazygit
    gh
    universal-ctags
    neovim
    tree-sitter
    python3

    # Rust toolchain (stable, from nixpkgs). rust-analyzer is installed via
    # Mason; RUST_SRC_PATH below points it at the std library source.
    rustc
    cargo
    clippy
    rustfmt

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

  # rust-analyzer (installed via Mason) needs the std library source to provide
  # completion/hover for std. nixpkgs ships it as a separate path.
  home.sessionVariables.RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";

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
    prefix = "C-b";
    plugins = with pkgs.tmuxPlugins; [ sensible vim-tmux-navigator ];
  };

  # Native module: starship. home-manager renders these settings to
  # ~/.config/starship.toml. `\$` escapes a literal `$` for nix; `\${count}`
  # passes a literal `${count}` through to starship's own templating.
  programs.starship = {
    enable = true;
    settings = {
      right_format = "$time";
      command_timeout = 5000;

      format = ''
        [┌─](bold bright-black) $directory$git_branch$git_status$nix_shell$shlvl$nodejs$python$java$lua$rust$package$cmd_duration$custom$status
        [└─](bold bright-black)$character'';

      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        style = "cyan";
        repo_root_style = "bold purple";
        read_only = " ";
        repo_root_format = "[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
      };

      git_status = {
        staged = "+\${count}";
        modified = "!\${count}";
        deleted = "✘\${count}";
        renamed = "»\${count}";
        untracked = "?\${count}";
        conflicted = "=\${count}";
        stashed = "\\\$\${count}";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇡\${ahead_count}⇣\${behind_count}";
      };

      # Warn when this isn't a top-level shell (nix shell, manual subshells, …).
      # `nix shell` spawns a child shell so SHLVL increments; it sets no marker
      # env var, so SHLVL is the honest signal. threshold is "show at this depth
      # or deeper" — tune to (baseline SHLVL of a normal terminal + 1).
      shlvl = {
        disabled = false;
        threshold = 2;
        symbol = "↕ ";
        style = "bold yellow";
        format = "[$symbol$shlvl]($style) ";
      };

      cmd_duration = {
        min_time = 200;
        format = "took [$duration](bold yellow) ";
      };

      time = {
        disabled = false;
        style = "bold bright-black";
        format = "[$time]($style)";
      };

      status = {
        disabled = false;
        symbol = "✗";
        style = "bold red";
        format = "[\\[$symbol$status_common_meaning$status_signal_name$status_maybe_int\\]]($style) ";
        map_symbol = true;
      };

      character = {
        success_symbol = "[➤](bold green)";
        error_symbol = "[➤](bold red)";
      };

      custom.sf = {
        description = "Salesforce target org";
        detect_files = [ "sfdx-project.json" ];
        symbol = "☁ ";
        style = "bold bright-blue";
        command = "starship-sf-org";
        format = "using [$symbol$output ](bright-blue)";
      };
    };
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
  xdg.configFile."ghostty".source = link "dot-config/ghostty";
  xdg.configFile."yazi".source = link "dot-config/yazi";
}
