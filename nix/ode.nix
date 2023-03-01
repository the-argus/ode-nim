{
  stdenv,
  callPackage,
  cmakeMinimal,
  musl,
  gcc,
  ...
}:
stdenv.mkDerivation {
  name = "ode";
  version = "0.16.3";

  buildInputs = [cmakeMinimal musl];

  src = callPackage ./src.nix {};

  CC = "${gcc}/bin/gcc -static";

  configurePhase = ''
    cmake -D ODE_WITH_DEMOS=OFF -D BUILD_SHARED_LIBS=OFF -D ODE_WITH_TESTS=OFF --install-prefix $out -S . -B build
    cd build
  '';
}
