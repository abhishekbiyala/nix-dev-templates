{
  description =
    "A Nix-flake-based development environment for GitHub Actions";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    }:

    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      action-validator = pkgs.callPackage ./action-validator/default.nix { };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          pre-commit
          act
          actionlint
          action-validator
        ];

        shellHook = with pkgs; ''
          echo "terraform `${terraform}/bin/terraform --version`"
        '';
      };
    });
}
