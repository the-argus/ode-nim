{
  stdenvNoCC,
  header,
  nimPackages,
  coreutils-full,
  ...
}: let
  # nim doesnt like keywords that start with underscores
  # these are the ones I found in the source code that we should remove
  underscoreKeywords = [
    "_planes"
    "_points"
    "_pointcount"
    "_planecount"
    "_polygons"
    "_count"
    "_p1"
    "_p2"
  ];
  kw = word: builtins.replaceStrings ["_"] [""] word;
  toReplaceCommand = ukeyword: ''sed -i -E "s/([^a-zA-Z])${ukeyword}/\1${kw ukeyword}/g" $out/ode.nim'';
  replaceCommands =
    builtins.concatStringsSep
    "\n"
    (map toReplaceCommand underscoreKeywords);

  # these are the types which are not defined which need to have their definition
  # inserted before they are mentioned. "targetBefore" is the pattern which,
  # when matched, places "contents" after it
  insert_definitions = [
    {
      targetBefore = "va_list";
      # note: this relies on the line that contains va_list being in a "type" block
      contents =
        builtins.toFile "va_list.nim"
        "  va_list* {.importc: \"va_list\", header: \"<stdarg.h>\".} = object";
    }
    {
      targetBefore = "dThreadingImplResourcesForCallsPreallocateFunction$";
      contents = ./thread_types.nim;
    }
  ];

  toInsertCommand = entry: ''sed -i -e "/${entry.targetBefore}/r ${entry.contents}" $out/ode.nim'';

  insertCommands =
    builtins.concatStringsSep "\n"
    (map toInsertCommand insert_definitions);
in
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
      # replace forward declarations with this:
      # type [typename] {.header: "ode/ode.h".} = object
      sed -i -E "s|^discard \"forward decl of (.*?)\"|type \1 {.header: \"ode/ode.h\".} = object|g" $out/ode.nim

      # replace all of the variables that start with _
      ${replaceCommands}

      # insert necessary definitions
      ${insertCommands}
    '';
  }
