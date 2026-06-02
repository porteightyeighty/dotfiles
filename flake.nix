{
  description = "Portable home-manager config — works for whatever account runs it";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      # Everything is read from the environment so a single config serves any
      # platform / account without enumeration. This is why switches need
      # `--impure` (currentSystem + getEnv are only populated in impure eval).
      system = builtins.currentSystem;        # aarch64-darwin, x86_64-linux, ...
      username = builtins.getEnv "USER";
      homeDirectory = builtins.getEnv "HOME";  # /Users/... on macOS, /home/... on Linux

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      config = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          {
            home.username = username;
            home.homeDirectory = homeDirectory;
          }
        ];
      };
    in
    {
      # Switch with:  home-manager switch --flake ~/dotfiles#default --impure
      # (`${username}` alias also lets the bare `--flake ~/dotfiles` form resolve.)
      homeConfigurations = {
        default = config;
        ${username} = config;
      };
    };
}
