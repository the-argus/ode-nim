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

    genSystems = nixpkgs.lib.genAttrs supportedSystems;

    pkgs =
      genSystems (system:
        import nixpkgs {inherit system;});
  in {
    packages = genSystems (system: {
      default = self.packages.${system}.ode;
      header = pkgs.${system}.callPackage ./header.nix {};
      ode = pkgs.${system}.callPackage ./bindings.nix {
        inherit (self.packages.${system}) header;
      };
    });

    devShell = genSystems (system:
      pkgs.${system}.mkShell {
        packages = with pkgs.${system}; [
          python3Minimal
          nim
          nimPackages.c2nim
          ode
        ];
      });
  };
}
