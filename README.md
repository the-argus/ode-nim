# ode-nim

Nim bindings for Open Dynamics Engine

## Build for bindings

Functions are generated using the nix build, but the contents of types.h is hand
copied. There are some additional touchups done afterwards.

## Known issues

I made these during my free time over the course of 2-3 days at the time of
writing, so they're not exactly the most comprehensive bindings. Being
procedurally generated means they're not very nim-like, and some of the patched
elements simply don't work. And the error messages are not informative at all.

- Fix the types which just contain ``dummy: int``. They need to be properly
sized to match the types they refer to in C. Main one I've encountered is
``dMass``, a very crucial type for using this library.
- Take the ``dThing(Set|Get)Value`` getter/setter functions with
``proc \`value=\` `` procs, so you can just call ``thing.value = foo``.

## Building your ode-nim project

Install ODE *as a dynamic library*. On linux that would be ``libode.so``. Then,
pass the ``-lode`` flag to the linker, like so:

```bash
nim c --passL:-lode path/to/entrypoint.nim
```

The same flag can also be passed to ``nimble build``. Alternatively, you can
place the following line in a ``nim.cfg`` file in your source directory:

```txt
passl = "-lode"
```

## Static build

If you want to build a project with ODE statically, you must use the cpp backend
(for now). Get a static version of libode, which on linux would be ``libode.a``.
Then run the following command:

```bash
nim cpp --passL:path/to/libode.a --passC:-static
```

Or, with ``nimble build``:

```bash
nimble build --backend:cpp --passL:path/to/libode.a --passC:-static
```
