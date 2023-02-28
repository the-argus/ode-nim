{ stdenvNoCC
, fetchgit
, ...
}:
let
  files = [
    "odeconfig.h"
    "compatibility.h"
    "common.h"
    "odeinit.h"
    "contact.h"
    "error.h"
    "memory.h"
    "odemath.h"
    "matrix.h"
    "matrix_coop.h"
    "timer.h"
    "rotation.h"
    "mass.h"
    "misc.h"
    "objects.h"
    "collision_space.h"
    "collision.h"
    "threading.h"
    "threading_impl.h"
    "cooperative.h"
    "export-dif.h"
    "version.h.in"
  ];

  extraHeaderContents = builtins.toFile "nimHeader" ''
    #ifdef C2NIM
    #  dynlib odedll
    #  cdecl
    #  if defined(windows)
    #    define odedll "ode.dll"
    #  elif defined(macosx)
    #    define odedll "libode.dylib"
    #  else
    #    define odedll "libode.so"
    #  endif
    #endif
  '';

  toCommand = file: "cat $src/include/ode/${file} >> $out/ode.h";

  commands = builtins.concatStringsSep "\n" (map toCommand files);
in
stdenvNoCC.mkDerivation {
  name = "massive-ODE-headerfile";
  src = fetchgit {
    url = "https://bitbucket.org/odedevs/ode.git";
    rev = "60ed40ff46ab228368cd8ce766d5c4a4cd6e33bd";
    sha256 = "0xsypfa6zxs2ddv76672aj6zza79hiyz21mlf08plbij0z859a1i";
  };
  dontUnpack = true;
  dontBuild = true;

  installPhase =
    ''
      mkdir -p $out
      cat ${extraHeaderContents} >> $out/ode.h
    ''
    + commands;

  postFixup = ''
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
