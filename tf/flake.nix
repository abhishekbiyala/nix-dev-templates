{
  description =
    "A Nix-flake-based development environment for Terraform";

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
      tfupdate = pkgs.callPackage ./tfupdate/default.nix { };
      hcledit = pkgs.callPackage ./hcledit/default.nix { };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          terraform
          tflint
          terragrunt
          infracost
          checkov
          terraform-docs
          tfsec
          tfupdate
          hcledit
        ];

        shellHook = with pkgs; ''
          echo "terraform `${terraform}/bin/terraform --version`"
          ${terragrunt}/bin/terragrunt --version
        '';
      };
    });
}
