{
  description = "Nim bindings for the Open Dynamics Engine";

  inputs.nixpkgs.url = github:nixos/nixpkgs;

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    systemToMusl = {
      "x86_64-linux" = "x86_64-unknown-linux-musl";
      "aarch64-linux" = "aarch64-unknown-linux-musl";
    };

    genSystems = nixpkgs.lib.genAttrs supportedSystems;

    pkgs =
      genSystems (system:
        import nixpkgs {inherit system;});
    muslPkgs = genSystems (system:
      import nixpkgs {
        localSystem = {
          inherit system;
          libc = "musl";
          config = systemToMusl.${system};
        };
      });
  in {
    packages = genSystems (system: {
      default = self.packages.${system}.bindings;
      header = pkgs.${system}.callPackage ./nix/header.nix {};
      bindings = pkgs.${system}.callPackage ./nix/bindings.nix {
        inherit (self.packages.${system}) header;
      };
      ode-src = pkgs.${system}.callPackage ./nix/src.nix {};

      ode = pkgs.${system}.callPackage ./nix/ode.nix {static = false;};
      ode-static = pkgs.${system}.callPackage ./nix/ode.nix {static = true;};
    });

    devShell = genSystems (system:
      pkgs.${system}.mkShell {
        packages = with pkgs.${system}; [
          nim
          nimPackages.c2nim
          # musl
          (self.packages.${system}.ode)
        ];
      });
  };
}
