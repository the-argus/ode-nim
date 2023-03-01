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

      ode = pkgs.${system}.callPackage ./nix/ode.nix { inherit (muslPkgs.${system}) gcc;};
    });

    devShell = genSystems (system:
      pkgs.${system}.mkShell {
        packages = with pkgs.${system}; [
          python3Minimal
          nim
          nimPackages.c2nim
          ode
          musl
        ];
      });
  };
}
