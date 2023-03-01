{
  stdenv,
  callPackage,
  cmakeMinimal,
  static ? false,
  musl,
  lib,
  ...
}: let
  shared_libs =
    if static
    then "OFF"
    else "ON";
in
  stdenv.mkDerivation ({
      name = "ode";
      version = "0.16.3";

      buildInputs =
        [
          cmakeMinimal
        ]
        ++ (lib.lists.optionals static [musl]);

      src = callPackage ./src.nix {};

      configurePhase = ''
        cmake -D ODE_WITH_DEMOS=OFF -D BUILD_SHARED_LIBS=${shared_libs} -D ODE_WITH_TESTS=OFF --install-prefix $out -S . -B build
        cd build
      '';
    }
    // (lib.attrsets.optionalAttrs static {
      CC = "musl-gcc -static";
    }))
