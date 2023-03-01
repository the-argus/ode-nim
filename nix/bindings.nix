{
  stdenvNoCC,
  header,
  nimPackages,
  coreutils-full,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "ode-nim";
  src = header;
  dontUnpack = true;

  buildInputs = [nimPackages.c2nim];

  buildPhase = ''
    cp $src/ode.h .
    ${coreutils-full}/bin/chmod +w ode.h

    c2nim ode.h --skipinclude --stdints --importc
  '';

  installPhase = ''
    mkdir -p $out
    # exclude comments in the output
    grep -vE "^##.*?" ode.nim > $out/ode.nim
  '';

  postFixup = ''
    sed -i -E "s|^discard \"forward decl of (.*?)\"|type\n  \1\* = object\n    dummy: int|g" $out/ode.nim
  '';
}