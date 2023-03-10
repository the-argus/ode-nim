{
  stdenvNoCC,
  callPackage,
  coreutils-full,
  python3Minimal,
  ...
}: let
  create_header = stdenvNoCC.mkDerivation {
    name = "create_header";

    src = ./create_header.py;

    dontUnpack = true;

    buildInputs = [python3Minimal];

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/create_header
      ${coreutils-full}/bin/chmod +x $out/bin/create_header
    '';
  };
in
  stdenvNoCC.mkDerivation {
    name = "massive-ODE-headerfile";
    src = callPackage ./src.nix {};
    dontUnpack = true;
    dontBuild = true;

    buildInputs = [create_header];

    installPhase = ''
      mkdir -p $out
      cat ${./types.h} >> $out/ode.h
      create_header "$src/include/ode" "./ode.h"
      cat ode.h >> $out/ode.h
    '';

    postFixup = ''
      sed -i "s/ODE_NORETURN//g" $out/ode.h
      # remove patterns that break c2nim for some reason
      sed -i "s/#define ODE_PURE_INLINE static __inline//g" $out/ode.h
      sed -i "s/#define ODE_INLINE __inline//g" $out/ode.h
      # manually apply these #defines with sed
      sed -i "s/ODE_PURE_INLINE/static __inline/g" $out/ode.h
      sed -i "s/ODE_INLINE/__inline/g" $out/ode.h

      # these both could cause bad glitches, but uh.  they work
      sed -i "s/#define ODE_NORETURN __attribute__((noreturn))//g" $out/ode.h
      # TODO: replace the stuff generated with these types with "culonglong" in nim
      sed -i "s/typedef unsigned long long duint64;/typedef unsigned long  duint64;/g" $out/ode.h

      # this one also
      sed -i "s/#define dNaN ({ union { duint32 m_ui; float m_f; } un; un.m_ui = 0x7FC00000; un.m_f; })//g" $out/ode.h

      # lose these, its only used when using c++ anyways
      sed -i "s/_dNaNUnion(): m_ui(0x7FC00000) {}//g" $out/ode.h
      sed -i "s/ODE_EXTERN_C float _nextafterf(float x, float y);/float _nextafterf(float x, float y);/g" $out/ode.h

      # remove stuff for defines with ODE_API
      sed -i "s/#define ODE_API __declspec(dllexport)//g" $out/ode.h
      sed -i "s/#define ODE_API//g" $out/ode.h

      # remove ODE_API
      sed -i "s/^ODE_API //g" $out/ode.h
    '';
  }
