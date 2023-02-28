when defined(windows):
  const
    odedll* = "ode.dll"
elif defined(macosx):
  const
    odedll* = "libode.dylib"
else:
  const
    odedll* = "libode.so"


type
  duint64* = uint64_t
  dint32* = int32_t
  duint32* = uint32_t
  dint16* = int16_t
  duint16* = uint16_t
  dint8* = int8_t
  duint8* = uint8_t
  dintptr* = intptr_t
  duintptr* = uintptr_t
  ddiffint* = ptrdiff_t
  dsizeint* = csize_t

const
  X86_64_SYSTEM* = 1


type
  duint64* = cu__int64


type
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


type
  duint64* = cu__int64



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


const
  dNaN* = (_dNaNUnion().m_f)

when defined(dSINGLE):
  const
    dNaN* = ((float)(dInfinity - dInfinity))
else:
  const
    dNaN* = (dInfinity - dInfinity)


template _ode_copysignf*(x, y: untyped): untyped =
  copysignf(x, y)

template _ode_copysign*(x, y: untyped): untyped =
  copysign(x, y)

template _ode_nextafterf*(x, y: untyped): untyped =
  nextafterf(x, y)

template _ode_nextafter*(x, y: untyped): untyped =
  nextafter(x, y)

when defined(_MSC_VER) and _MSC_VER < 1700:
  proc _ode_fmin*(x: cdouble; y: cdouble): cdouble {.inline, cdecl.} =
    return __min(x, y)

  proc _ode_fmax*(x: cdouble; y: cdouble): cdouble {.inline, cdecl.} =
    return __max(x, y)

  proc _ode_fminf*(x: cfloat; y: cfloat): cfloat {.inline, cdecl.} =
    return __min(x, y)

  proc _ode_fmaxf*(x: cfloat; y: cfloat): cfloat {.inline, cdecl.} =
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



template dOP*(a, op, b, c: untyped): void =
  while true:
    if not 0:
      break

template dOPC*(a, op, b, c: untyped): void =
  while true:
    if not 0:
      break

template dOPE*(a, op, b: untyped): void =
  while true:
    if not 0:
      break

template dOPEC*(a, op, c: untyped): void =
  while true:
    if not 0:
      break


template dOPE2*(a, op1, b, op2, c: untyped): void =
  while true:
    if not 0:
      break

template dLENGTHSQUARED*(a: untyped): untyped =
  dCalcVectorLengthSquare3(a)

template dLENGTH*(a: untyped): untyped =
  dCalcVectorLength3(a)

template dDISTANCE*(a, b: untyped): untyped =
  dCalcPointsDistance3(a, b)

template dDOT*(a, b: untyped): untyped =
  dCalcVectorDot3(a, b)

template dDOT13*(a, b: untyped): untyped =
  dCalcVectorDot3_13(a, b)

template dDOT31*(a, b: untyped): untyped =
  dCalcVectorDot3_31(a, b)

template dDOT33*(a, b: untyped): untyped =
  dCalcVectorDot3_33(a, b)

template dDOT14*(a, b: untyped): untyped =
  dCalcVectorDot3_14(a, b)

template dDOT41*(a, b: untyped): untyped =
  dCalcVectorDot3_41(a, b)

template dDOT44*(a, b: untyped): untyped =
  dCalcVectorDot3_44(a, b)


template dCROSS*(a, op, b, c: untyped): void =
  while true:
    if not 0:
      break

template dCROSSpqr*(a, op, b, c, p, q, r: untyped): void =
  while true:
    if not 0:
      break

template dCROSS114*(a, op, b, c: untyped): untyped =
  dCROSSpqr(a, op, b, c, 1, 1, 4)

template dCROSS141*(a, op, b, c: untyped): untyped =
  dCROSSpqr(a, op, b, c, 1, 4, 1)

template dCROSS144*(a, op, b, c: untyped): untyped =
  dCROSSpqr(a, op, b, c, 1, 4, 4)

template dCROSS411*(a, op, b, c: untyped): untyped =
  dCROSSpqr(a, op, b, c, 4, 1, 1)

template dCROSS414*(a, op, b, c: untyped): untyped =
  dCROSSpqr(a, op, b, c, 4, 1, 4)

template dCROSS441*(a, op, b, c: untyped): untyped =
  dCROSSpqr(a, op, b, c, 4, 4, 1)

template dCROSS444*(a, op, b, c: untyped): untyped =
  dCROSSpqr(a, op, b, c, 4, 4, 4)


template dCROSSMAT*(A, a, skip, plus, minus: untyped): void =
  while true:
    (A)[1] = minus(a)[2]
    (A)[2] = plus(a)[1]
    (A)[(skip) + 0] = plus(a)[2]
    (A)[(skip) + 2] = minus(a)[0]
    (A)[2 * (skip) + 0] = minus(a)[1]
    (A)[2 * (skip) + 1] = plus(a)[0]
    if not 0:
      break


template dMULTIPLY0_331*(A, B, C: untyped): untyped =
  dMultiply0_331(A, B, C)

template dMULTIPLY1_331*(A, B, C: untyped): untyped =
  dMultiply1_331(A, B, C)

template dMULTIPLY0_133*(A, B, C: untyped): untyped =
  dMultiply0_133(A, B, C)

template dMULTIPLY0_333*(A, B, C: untyped): untyped =
  dMultiply0_333(A, B, C)

template dMULTIPLY1_333*(A, B, C: untyped): untyped =
  dMultiply1_333(A, B, C)

template dMULTIPLY2_333*(A, B, C: untyped): untyped =
  dMultiply2_333(A, B, C)

template dMULTIPLYADD0_331*(A, B, C: untyped): untyped =
  dMultiplyAdd0_331(A, B, C)

template dMULTIPLYADD1_331*(A, B, C: untyped): untyped =
  dMultiplyAdd1_331(A, B, C)

template dMULTIPLYADD0_133*(A, B, C: untyped): untyped =
  dMultiplyAdd0_133(A, B, C)

template dMULTIPLYADD0_333*(A, B, C: untyped): untyped =
  dMultiplyAdd0_333(A, B, C)

template dMULTIPLYADD1_333*(A, B, C: untyped): untyped =
  dMultiplyAdd1_333(A, B, C)

template dMULTIPLYADD2_333*(A, B, C: untyped): untyped =
  dMultiplyAdd2_333(A, B, C)



