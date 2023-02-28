{
  stdenvNoCC,
  fetchgit,
  ...
}: let
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
  }
