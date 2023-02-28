{
  stdenvNoCC,
  fetchgit,
  ...
}: let
  files = [
    "common.h"
    "collision.h"
    "cooperative.h"
    "matrix.h"
    "objects.h"
    "odemath.h"
    "threading_impl.h"
    "collision_space.h"
    "compatibility.h"
    "error.h"
    "mass.h"
    "memory.h"
    "odeconfig.h"
    "odemath_legacy.h"
    "rotation.h"
    "timer.h"
    "collision_trimesh.h"
    "contact.h"
    "export-dif.h"
    "matrix_coop.h"
    "misc.h"
    "odeinit.h"
    "threading.h"
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
  }
