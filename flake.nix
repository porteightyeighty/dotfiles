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
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      # Read the running account from the environment so a single config serves
      # any user/home without enumerating names. This is why switches need
      # `--impure` (getEnv is only populated in impure eval).
      username = builtins.getEnv "USER";

      config = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          {
            home.username = username;
            home.homeDirectory = "/Users/${username}";
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
