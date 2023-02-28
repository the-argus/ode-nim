when defined(windows):
  const
    odedll* = "ode.dll"
elif defined(macosx):
  const
    odedll* = "libode.dylib"
else:
  const
    odedll* = "libode.so"


when defined(ODE_DLL) or defined(ODE_LIB):
  discard

when defined(_MSC_VER) or (defined(__GNUC__) and defined(_WIN32)):
  when defined(ODE_DLL):
    discard
  else:
    discard
when not defined(ODE_API):
  discard
when defined(_MSC_VER):
  discard
elif defined(__GNUC__) and
    ((__GNUC__ > 3) or ((__GNUC__ == 3) and (__GNUC_MINOR__ >= 1))):
  const
    __declspec* = cast[deprecated](__attribute__((__deprecated__)))
else:
  const
    __declspec* = (deprecated)
when defined(__GNUC__):
  discard
elif defined(_MSC_VER):
  discard
else:
  const
    __declspec* = (noreturn)

when defined(__aarch64__) or defined(__alpha__) or defined(__ppc64__) or
    defined(__s390__) or defined(__s390x__) or defined(__zarch__) or
    defined(__mips__) or defined(__powerpc64__) or defined(__riscv) or
    defined(__loongarch64) or (defined(__sparc__) and defined(__arch64__)):
  type
    dint64* = int64
    duint64* = uint64
    dint32* = int32
    duint32* = uint32
    dint16* = int16
    duint16* = uint16
    dint8* = int8
    duint8* = uint8
    dintptr* = intptr_t
    duintptr* = uintptr_t
    ddiffint* = ptrdiff_t
    dsizeint* = csize_t
elif (defined(_M_IA64) or defined(__ia64__) or defined(_M_AMD64) or
    defined(__x86_64__)) and not defined(__ILP32__) and not defined(_ILP32):
  const
    X86_64_SYSTEM* = 1
  when defined(_MSC_VER):
    type
      dint64* = __int64
      duint64* = cu__int64
  else:
    when defined(_LP64) or defined(__LP64__):
      type
        dint64* = clong
        duint64* = culong
    else:
      type
        dint64* = clonglong
        duint64* = culong
  type
    dint32* = cint
    duint32* = cuint
    dint16* = cshort
    duint16* = cushort
    dint8* = cchar
    duint8* = cuchar
    dintptr* = dint64
    duintptr* = duint64
    ddiffint* = dint64
    dsizeint* = duint64
else:
  when defined(_MSC_VER):
    type
      dint64* = __int64
      duint64* = cu__int64
  else:
    type
      dint64* = clonglong
      duint64* = culong
  type
    dint32* = cint
    duint32* = cuint
    dint16* = cshort
    duint16* = cushort
    dint8* = cchar
    duint8* = cuchar
    dintptr* = dint32
    duintptr* = duint32
    ddiffint* = dint32
    dsizeint* = duint32

when defined(INFINITY):
  when defined(dSINGLE):
    const
      dInfinity* = (cast[cfloat](INFINITY))
  else:
    const
      dInfinity* = (cast[cdouble](INFINITY))
elif defined(HUGE_VAL):
  when defined(dSINGLE):
    when defined(HUGE_VALF):
      const
        dInfinity* = HUGE_VALF
    else:
      const
        dInfinity* = (cast[cfloat](HUGE_VAL))
  else:
    const
      dInfinity* = HUGE_VAL
else:
  when defined(dSINGLE):
    const
      dInfinity* = ((float)(1.0 div 0.0))
  else:
    const
      dInfinity* = (1.0 div 0.0)

when defined(NAN):
  const
    dNaN* = NAN
elif defined(__GNUC__):
  discard
elif defined(__cplusplus):
  type
    _dNaNUnion* {.bycopy, union.} = object
      m_ui*: duint32
      m_f*: cfloat

  const
    dNaN* = (_dNaNUnion().m_f)
else:
  when defined(dSINGLE):
    const
      dNaN* = ((float)(dInfinity - dInfinity))
  else:
    const
      dNaN* = (dInfinity - dInfinity)

when defined(_MSC_VER):
  template _ode_copysignf*(x, y: untyped): untyped =
    (cast[cfloat](_copysign(x, y)))

  template _ode_copysign*(x, y: untyped): untyped =
    _copysign(x, y)

  template _ode_nextafterf*(x, y: untyped): untyped =
    _nextafterf(x, y)

  template _ode_nextafter*(x, y: untyped): untyped =
    _nextafter(x, y)

  when not defined(_WIN64) and defined(dSINGLE):
    proc _nextafterf*(x: cfloat; y: cfloat): cfloat {.cdecl, importc: "_nextafterf",
        dynlib: odedll.}
else:
  template _ode_copysignf*(x, y: untyped): untyped =
    copysignf(x, y)

  template _ode_copysign*(x, y: untyped): untyped =
    copysign(x, y)

  template _ode_nextafterf*(x, y: untyped): untyped =
    nextafterf(x, y)

  template _ode_nextafter*(x, y: untyped): untyped =
    nextafter(x, y)

when defined(_MSC_VER) and _MSC_VER < 1700:
  proc _ode_fmin*(x: cdouble; y: cdouble): cdouble {.inline, cdecl, importc: "_ode_fmin".} =
    return __min(x, y)

  proc _ode_fmax*(x: cdouble; y: cdouble): cdouble {.inline, cdecl, importc: "_ode_fmax".} =
    return __max(x, y)

  proc _ode_fminf*(x: cfloat; y: cfloat): cfloat {.inline, cdecl, importc: "_ode_fminf".} =
    return __min(x, y)

  proc _ode_fmaxf*(x: cfloat; y: cfloat): cfloat {.inline, cdecl, importc: "_ode_fmaxf".} =
    return __max(x, y)

else:
  template _ode_fmin*(x, y: untyped): untyped =
    fmin(x, y)

  template _ode_fmax*(x, y: untyped): untyped =
    fmax(x, y)

  template _ode_fminf*(x, y: untyped): untyped =
    fminf(x, y)

  template _ode_fmaxf*(x, y: untyped): untyped =
    fmaxf(x, y)



template dQtoR*(q, R: untyped): untyped =
  dRfromQ((R), (q))

template dRtoQ*(R, q: untyped): untyped =
  dQfromR((q), (R))

template dWtoDQ*(w, q, dq: untyped): untyped =
  dDQfromW((dq), (w), (q))


