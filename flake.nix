{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-update = {
      url = "github:nix-community/nixpkgs-update";
      inputs.runtimeDeps.follows = "nixpkgs";
      inputs.treefmt-nix.follows = "treefmt-nix";
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      ...
    }:
    let
      inherit (nixpkgs) lib;
    in
    flake-parts.lib.mkFlake { inherit inputs; } (
      top@{
        config,
        withSystem,
        moduleWithSystem,
        ...
      }:
      {
        imports = [
          inputs.treefmt-nix.flakeModule
          inputs.devshell.flakeModule
        ];
        systems = lib.systems.flakeExposed;
        perSystem =
          {
            self',
            config,
            pkgs,
            system,
            ...
          }:
          {
            devShells.default = self'.devShells.nixpkgs-update-gha;
            treefmt = {
              programs = {
                actionlint.enable = true;
                autocorrect.enable = true;
                nixfmt.enable = true;
              };
              settings.formatter.markdownlint = {
                enable = true;
                command = lib.getExe pkgs.markdownlint-cli2;
                options = [ "--fix" ];
                includes = [ "*.md" ];
              };
            };
            devshells.nixpkgs-update-gha = {
              packages =
                (with pkgs; [
                  nix
                  git
                  jq
                  nixpkgs-review
                ])
                ++ [ inputs.nixpkgs-update.packages.${system}.default ];
            };
          };
      }
    );
}
