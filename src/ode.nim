type dWorldStepReserveInfo* {.header: "ode/objects.h".} = object
type dWorldStepMemoryFunctionsInfo* {.header: "ode/objects.h".} = object
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
  time_t* = clong


type dWorldID {.header: "ode/ode.h".} = object

type dSpaceID {.header: "ode/ode.h".} = object

type dBodyID {.header: "ode/ode.h".} = object

type dGeomID {.header: "ode/ode.h".} = object

type dJointID {.header: "ode/ode.h".} = object

type dJointGroupID {.header: "ode/ode.h".} = object

type dResourceRequirementsID {.header: "ode/ode.h".} = object

type dResourceContainerID {.header: "ode/ode.h".} = object

type dCallWaitID {.header: "ode/ode.h".} = object

type dCallReleaseeID {.header: "ode/ode.h".} = object

type dMutexGroupID {.header: "ode/ode.h".} = object

type dThreadingImplementationID {.header: "ode/ode.h".} = object

type dHeightfieldDataID {.header: "ode/ode.h".} = object

type dThreadingThreadPoolID {.header: "ode/ode.h".} = object

type dCooperativeID {.header: "ode/ode.h".} = object


type
  dint32* = cint
  duint32* = cuint
  dint16* = cshort
  duint16* = cushort
  dint8* = cchar
  duint8* = cuchar
  dint64* = clonglong


type
  duint64* = culong
  dintptr* = dint64
  duintptr* = duint64
  ddiffint* = dint64
  dsizeint* = duint64
  dMessageFunction* = proc (errnum: cint; msg: cstring; ap: va_list): void {.cdecl.}
  va_list* {.importc: "va_list", header: "<stdarg.h>".} = object
  dAllocFunction* = proc (size: dsizeint): pointer {.cdecl.}
  dReallocFunction* = proc (`ptr`: pointer; oldsize: dsizeint; newsize: dsizeint): pointer {.
      cdecl.}
  dFreeFunction* = proc (`ptr`: pointer; size: dsizeint): void {.cdecl.}
  dReal* = cdouble
  dVector3* = array[3, dReal]
  dVector4* = array[4, dReal]
  dMatrix3* = array[9, dReal]
  dStopwatch* {.bycopy.} = object
    time*: cdouble
    cc*: array[2, culong]

  dQuaternion* = array[4, dReal]
  dMass* {.bycopy.} = object
    mass*: dReal
    c*: dVector3
    I*: dMatrix3






















type
  dThreadingImplResourcesForCallsPreallocateFunction* = proc (
      impl: dThreadingImplementationID;
      max_simultaneous_calls_estimate: ddependencycount_t): cint {.cdecl.}
  dThreadingFunctionsInfo* {.bycopy.} = object
    struct_size*: cuint
    alloc_mutex_group*: ptr dMutexGroupAllocFunction
    free_mutex_group*: ptr dMutexGroupFreeFunction
    lock_group_mutex*: ptr dMutexGroupMutexLockFunction
    unlock_group_mutex*: ptr dMutexGroupMutexUnlockFunction
    alloc_call_wait*: ptr dThreadedCallWaitAllocFunction
    reset_call_wait*: ptr dThreadedCallWaitResetFunction
    free_call_wait*: ptr dThreadedCallWaitFreeFunction
    post_call*: ptr dThreadedCallPostFunction
    alter_call_dependencies_count*: ptr dThreadedCallDependenciesCountAlterFunction
    wait_call*: ptr dThreadedCallWaitFunction
    retrieve_thread_count*: ptr dThreadingImplThreadCountRetrieveFunction
    preallocate_resources_for_calls*: ptr dThreadingImplResourcesForCallsPreallocateFunction
  ddependencycount_t* = dsizeint
  dcallindex_t* = dsizeint
  dmutexindex_t = uint
  ddependencychange_t = ddiffint
  dThreadedWaitTime* = object
    wait_sec: time_t
    wait_nsec: culong
  dMutexGroupAllocFunction* = proc (
    impl: dThreadingImplementationID,
    Mutex_count: dmutexindex_t,
    Mutex_names_ptr: char): dMutexGroupID
  dMutexGroupFreeFunction* = proc (
    impl: dThreadingImplementationID,
    mutex_group: dMutexGroupID): void
  dMutexGroupMutexLockFunction* = proc (
    impl: dThreadingImplementationID,
    mutex_group: dMutexGroupID,
    mutex_index: dmutexindex_t): void
  dMutexGroupMutexUnlockFunction* = proc (
    impl: dThreadingImplementationID,
    mutex_group: dMutexGroupID,
    mutex_index: dmutexindex_t): void
  dThreadedCallWaitAllocFunction* = proc (
    impl: dThreadingImplementationID): dCallWaitID
  dThreadedCallWaitResetFunction* = proc (
    impl: dThreadingImplementationID,
    call_wait: dCallWaitID): void
  dThreadedCallWaitFreeFunction* = proc (
    impl: dThreadingImplementationID,
    call_wait: dCallWaitID): void
  dThreadedCallFunction = proc (
    call_context: pointer,
    instance_index: dcallindex_t,
    this_releasee: dCallReleaseeID): int
  dThreadedCallPostFunction* = proc(
    impl: dThreadingImplementationID, out_summary_fault: ptr int,
    out_post_releasee: ptr dCallReleaseeID, dependencies_count: ddependencycount_t,
    dependent_releasee: dCallReleaseeID, call_wait: dCallWaitID,
    call_func: ptr dThreadedCallFunction, call_context: pointer,
    instance_index: dcallindex_t, call_name: ptr char)
  dThreadedCallDependenciesCountAlterFunction* = proc (
    impl: dThreadingImplementationID, target_releasee: dCallReleaseeID,
    dependencies_count_change: ddependencychange_t): void
  dThreadedCallWaitFunction* = proc (
    impl: dThreadingImplementationID, out_wait_status: ptr int,
    call_wait: dCallWaitID,
    timeout_time_ptr: ptr dThreadedWaitTime,
    wait_name: ptr char)
  dThreadingImplThreadCountRetrieveFunction = proc (
    impl: dThreadingImplementationID ): uint

  dWorldQuickStepIterationCount_DynamicAdjustmentStatistics* {.bycopy.} = object
    struct_size*: cuint
    iteration_count*: duint32
    premature_exits*: duint32
    prolonged_execs*: duint32
    full_extra_execs*: duint32

  dContactGeom* {.bycopy.} = object
    pos*: dVector3
    normal*: dVector3
    depth*: dReal
    g1*: dGeomID
    g2*: dGeomID
    side1*: cint
    side2*: cint

  dSurfaceParameters* {.bycopy.} = object
    mode*: cint
    mu*: dReal
    mu2*: dReal
    rho*: dReal
    rho2*: dReal
    rhoN*: dReal
    bounce*: dReal
    bounce_vel*: dReal
    soft_erp*: dReal
    soft_cfm*: dReal
    motion1*: dReal
    motion2*: dReal
    motionN*: dReal
    slip1*: dReal
    slip2*: dReal

  dContact* {.bycopy.} = object
    surface*: dSurfaceParameters
    geom*: dContactGeom
    fdir1*: dVector3

  dJointType* {.size: sizeof(cint).} = enum
    dJointTypeNone = 0, dJointTypeBall, dJointTypeHinge, dJointTypeSlider,
    dJointTypeContact, dJointTypeUniversal, dJointTypeHinge2, dJointTypeFixed,
    dJointTypeNull, dJointTypeAMotor, dJointTypeLMotor, dJointTypePlane2D,
    dJointTypePR, dJointTypePU, dJointTypePiston, dJointTypeDBall, dJointTypeDHinge,
    dJointTypeTransmission
  dJointFeedback* {.bycopy.} = object
    f1*: dVector3
    t1*: dVector3
    f2*: dVector3
    t2*: dVector3

  dNearCallback* = proc (data: pointer; o1: dGeomID; o2: dGeomID): void {.cdecl.}
  dHeightfieldGetHeight* = proc (p_user_data: pointer; x: cint; z: cint): dReal {.cdecl.}
  dGetAABBFn* = proc (a1: dGeomID; aabb: array[6, dReal]): void {.cdecl.}
  dColliderFn* = proc (o1: dGeomID; o2: dGeomID; flags: cint; contact: ptr dContactGeom;
                    skip: cint): cint {.cdecl.}
  dGetColliderFnFn* = proc (num: cint): ptr dColliderFn {.cdecl.}
  dGeomDtorFn* = proc (o: dGeomID): void {.cdecl.}
  dAABBTestFn* = proc (o1: dGeomID; o2: dGeomID; aabb: array[6, dReal]): cint {.cdecl.}
  dGeomClass* {.bycopy.} = object
    bytes*: cint
    collider*: ptr dGetColliderFnFn
    aabb*: ptr dGetAABBFn
    aabb_test*: ptr dAABBTestFn
    dtor*: ptr dGeomDtorFn

  dThreadReadyToServeCallback* = proc (callback_context: pointer) {.cdecl.}


proc dGetConfiguration*(): cstring {.cdecl, importc: "dGetConfiguration",
                                  dynlib: odedll.}
proc dCheckConfiguration*(token: cstring): cint {.cdecl,
    importc: "dCheckConfiguration", dynlib: odedll.}
proc dInitODE*() {.cdecl, importc: "dInitODE", dynlib: odedll.}
proc dInitODE2*(uiInitFlags: cuint): cint {.cdecl, importc: "dInitODE2", dynlib: odedll.}
  ## =0
proc dAllocateODEDataForThread*(uiAllocateFlags: cuint): cint {.cdecl,
    importc: "dAllocateODEDataForThread", dynlib: odedll.}
proc dCleanupODEAllDataForThread*() {.cdecl,
                                    importc: "dCleanupODEAllDataForThread",
                                    dynlib: odedll.}
proc dCloseODE*() {.cdecl, importc: "dCloseODE", dynlib: odedll.}
proc dSetErrorHandler*(fn: ptr dMessageFunction) {.cdecl,
    importc: "dSetErrorHandler", dynlib: odedll.}
proc dSetDebugHandler*(fn: ptr dMessageFunction) {.cdecl,
    importc: "dSetDebugHandler", dynlib: odedll.}
proc dSetMessageHandler*(fn: ptr dMessageFunction) {.cdecl,
    importc: "dSetMessageHandler", dynlib: odedll.}
proc dGetErrorHandler*(): ptr dMessageFunction {.cdecl, importc: "dGetErrorHandler",
    dynlib: odedll.}
proc dGetDebugHandler*(): ptr dMessageFunction {.cdecl, importc: "dGetDebugHandler",
    dynlib: odedll.}
proc dGetMessageHandler*(): ptr dMessageFunction {.cdecl,
    importc: "dGetMessageHandler", dynlib: odedll.}
proc dError*(num: cint; msg: cstring) {.varargs, cdecl, importc: "dError", dynlib: odedll.}
proc dDebug*(num: cint; msg: cstring) {.varargs, cdecl, importc: "dDebug", dynlib: odedll.}
proc dMessage*(num: cint; msg: cstring) {.varargs, cdecl, importc: "dMessage",
                                     dynlib: odedll.}
proc dSetAllocHandler*(fn: ptr dAllocFunction) {.cdecl, importc: "dSetAllocHandler",
    dynlib: odedll.}
proc dSetReallocHandler*(fn: ptr dReallocFunction) {.cdecl,
    importc: "dSetReallocHandler", dynlib: odedll.}
proc dSetFreeHandler*(fn: ptr dFreeFunction) {.cdecl, importc: "dSetFreeHandler",
    dynlib: odedll.}
proc dGetAllocHandler*(): ptr dAllocFunction {.cdecl, importc: "dGetAllocHandler",
    dynlib: odedll.}
proc dGetReallocHandler*(): ptr dReallocFunction {.cdecl,
    importc: "dGetReallocHandler", dynlib: odedll.}
proc dGetFreeHandler*(): ptr dFreeFunction {.cdecl, importc: "dGetFreeHandler",
    dynlib: odedll.}
proc dAlloc*(size: dsizeint): pointer {.cdecl, importc: "dAlloc", dynlib: odedll.}
proc dRealloc*(`ptr`: pointer; oldsize: dsizeint; newsize: dsizeint): pointer {.cdecl,
    importc: "dRealloc", dynlib: odedll.}
proc dFree*(`ptr`: pointer; size: dsizeint) {.cdecl, importc: "dFree", dynlib: odedll.}
proc dSafeNormalize3*(a: dVector3): cint {.cdecl, importc: "dSafeNormalize3",
                                       dynlib: odedll.}
proc dSafeNormalize4*(a: dVector4): cint {.cdecl, importc: "dSafeNormalize4",
                                       dynlib: odedll.}
proc dNormalize3*(a: dVector3) {.cdecl, importc: "dNormalize3", dynlib: odedll.}

proc dNormalize4*(a: dVector4) {.cdecl, importc: "dNormalize4", dynlib: odedll.}

proc dPlaneSpace*(n: dVector3; p: dVector3; q: dVector3) {.cdecl,
    importc: "dPlaneSpace", dynlib: odedll.}
proc dOrthogonalizeR*(m: dMatrix3): cint {.cdecl, importc: "dOrthogonalizeR",
                                       dynlib: odedll.}
proc dSetZero*(a: ptr dReal; n: cint) {.cdecl, importc: "dSetZero", dynlib: odedll.}
proc dSetValue*(a: ptr dReal; n: cint; value: dReal) {.cdecl, importc: "dSetValue",
    dynlib: odedll.}
proc dDot*(a: ptr dReal; b: ptr dReal; n: cint): dReal {.cdecl, importc: "dDot",
    dynlib: odedll.}
proc dMultiply0*(A: ptr dReal; B: ptr dReal; C: ptr dReal; p: cint; q: cint; r: cint) {.cdecl,
    importc: "dMultiply0", dynlib: odedll.}
proc dMultiply1*(A: ptr dReal; B: ptr dReal; C: ptr dReal; p: cint; q: cint; r: cint) {.cdecl,
    importc: "dMultiply1", dynlib: odedll.}
proc dMultiply2*(A: ptr dReal; B: ptr dReal; C: ptr dReal; p: cint; q: cint; r: cint) {.cdecl,
    importc: "dMultiply2", dynlib: odedll.}
proc dFactorCholesky*(A: ptr dReal; n: cint): cint {.cdecl, importc: "dFactorCholesky",
    dynlib: odedll.}
proc dSolveCholesky*(L: ptr dReal; b: ptr dReal; n: cint) {.cdecl,
    importc: "dSolveCholesky", dynlib: odedll.}
proc dInvertPDMatrix*(A: ptr dReal; Ainv: ptr dReal; n: cint): cint {.cdecl,
    importc: "dInvertPDMatrix", dynlib: odedll.}
proc dIsPositiveDefinite*(A: ptr dReal; n: cint): cint {.cdecl,
    importc: "dIsPositiveDefinite", dynlib: odedll.}
proc dFactorLDLT*(A: ptr dReal; d: ptr dReal; n: cint; nskip: cint) {.cdecl,
    importc: "dFactorLDLT", dynlib: odedll.}
proc dSolveL1*(L: ptr dReal; b: ptr dReal; n: cint; nskip: cint) {.cdecl,
    importc: "dSolveL1", dynlib: odedll.}
proc dSolveL1T*(L: ptr dReal; b: ptr dReal; n: cint; nskip: cint) {.cdecl,
    importc: "dSolveL1T", dynlib: odedll.}
proc dScaleVector*(a: ptr dReal; d: ptr dReal; n: cint) {.cdecl, importc: "dScaleVector",
    dynlib: odedll.}
proc dSolveLDLT*(L: ptr dReal; d: ptr dReal; b: ptr dReal; n: cint; nskip: cint) {.cdecl,
    importc: "dSolveLDLT", dynlib: odedll.}
proc dLDLTAddTL*(L: ptr dReal; d: ptr dReal; a: ptr dReal; n: cint; nskip: cint) {.cdecl,
    importc: "dLDLTAddTL", dynlib: odedll.}
proc dLDLTRemove*(A: ptr ptr dReal; p: ptr cint; L: ptr dReal; d: ptr dReal; n1: cint; n2: cint;
                 r: cint; nskip: cint) {.cdecl, importc: "dLDLTRemove", dynlib: odedll.}
proc dRemoveRowCol*(A: ptr dReal; n: cint; nskip: cint; r: cint) {.cdecl,
    importc: "dRemoveRowCol", dynlib: odedll.}
proc dEstimateCooperativelyFactorLDLTResourceRequirements*(
    requirements: dResourceRequirementsID; maximalAllowedThreadCount: cuint;
    maximalRowCount: cuint) {.cdecl, importc: "dEstimateCooperativelyFactorLDLTResourceRequirements",
                            dynlib: odedll.}
proc dCooperativelyFactorLDLT*(resources: dResourceContainerID;
                              allowedThreadCount: cuint; A: ptr dReal; d: ptr dReal;
                              rowCount: cuint; rowSkip: cuint) {.cdecl,
    importc: "dCooperativelyFactorLDLT", dynlib: odedll.}
proc dEstimateCooperativelySolveLDLTResourceRequirements*(
    requirements: dResourceRequirementsID; maximalAllowedThreadCount: cuint;
    maximalRowCount: cuint) {.cdecl, importc: "dEstimateCooperativelySolveLDLTResourceRequirements",
                            dynlib: odedll.}
proc dCooperativelySolveLDLT*(resources: dResourceContainerID;
                             allowedThreadCount: cuint; L: ptr dReal; d: ptr dReal;
                             b: ptr dReal; rowCount: cuint; rowSkip: cuint) {.cdecl,
    importc: "dCooperativelySolveLDLT", dynlib: odedll.}
proc dEstimateCooperativelySolveL1StraightResourceRequirements*(
    requirements: dResourceRequirementsID; maximalAllowedThreadCount: cuint;
    maximalRowCount: cuint) {.cdecl, importc: "dEstimateCooperativelySolveL1StraightResourceRequirements",
                            dynlib: odedll.}
proc dCooperativelySolveL1Straight*(resources: dResourceContainerID;
                                   allowedThreadCount: cuint; L: ptr dReal;
                                   b: ptr dReal; rowCount: cuint; rowSkip: cuint) {.
    cdecl, importc: "dCooperativelySolveL1Straight", dynlib: odedll.}
proc dEstimateCooperativelySolveL1TransposedResourceRequirements*(
    requirements: dResourceRequirementsID; maximalAllowedThreadCount: cuint;
    maximalRowCount: cuint) {.cdecl, importc: "dEstimateCooperativelySolveL1TransposedResourceRequirements",
                            dynlib: odedll.}
proc dCooperativelySolveL1Transposed*(resources: dResourceContainerID;
                                     allowedThreadCount: cuint; L: ptr dReal;
                                     b: ptr dReal; rowCount: cuint; rowSkip: cuint) {.
    cdecl, importc: "dCooperativelySolveL1Transposed", dynlib: odedll.}
proc dEstimateCooperativelyScaleVectorResourceRequirements*(
    requirements: dResourceRequirementsID; maximalAllowedThreadCount: cuint;
    maximalElementCount: cuint) {.cdecl, importc: "dEstimateCooperativelyScaleVectorResourceRequirements",
                                dynlib: odedll.}
proc dCooperativelyScaleVector*(resources: dResourceContainerID;
                               allowedThreadCount: cuint; dataVector: ptr dReal;
                               scaleVector: ptr dReal; elementCount: cuint) {.cdecl,
    importc: "dCooperativelyScaleVector", dynlib: odedll.}
proc dStopwatchReset*(a1: ptr dStopwatch) {.cdecl, importc: "dStopwatchReset",
                                        dynlib: odedll.}
proc dStopwatchStart*(a1: ptr dStopwatch) {.cdecl, importc: "dStopwatchStart",
                                        dynlib: odedll.}
proc dStopwatchStop*(a1: ptr dStopwatch) {.cdecl, importc: "dStopwatchStop",
                                       dynlib: odedll.}
proc dStopwatchTime*(a1: ptr dStopwatch): cdouble {.cdecl, importc: "dStopwatchTime",
    dynlib: odedll.}

proc dTimerStart*(description: cstring) {.cdecl, importc: "dTimerStart",
                                       dynlib: odedll.}

proc dTimerNow*(description: cstring) {.cdecl, importc: "dTimerNow", dynlib: odedll.}

proc dTimerEnd*() {.cdecl, importc: "dTimerEnd", dynlib: odedll.}
proc dTimerReport*(fout: ptr FILE; average: cint) {.cdecl, importc: "dTimerReport",
    dynlib: odedll.}
proc dTimerTicksPerSecond*(): cdouble {.cdecl, importc: "dTimerTicksPerSecond",
                                     dynlib: odedll.}
proc dTimerResolution*(): cdouble {.cdecl, importc: "dTimerResolution", dynlib: odedll.}
proc dRSetIdentity*(R: dMatrix3) {.cdecl, importc: "dRSetIdentity", dynlib: odedll.}
proc dRFromAxisAndAngle*(R: dMatrix3; ax: dReal; ay: dReal; az: dReal; angle: dReal) {.
    cdecl, importc: "dRFromAxisAndAngle", dynlib: odedll.}
proc dRFromEulerAngles*(R: dMatrix3; phi: dReal; theta: dReal; psi: dReal) {.cdecl,
    importc: "dRFromEulerAngles", dynlib: odedll.}
proc dRFrom2Axes*(R: dMatrix3; ax: dReal; ay: dReal; az: dReal; bx: dReal; by: dReal;
                 bz: dReal) {.cdecl, importc: "dRFrom2Axes", dynlib: odedll.}
proc dRFromZAxis*(R: dMatrix3; ax: dReal; ay: dReal; az: dReal) {.cdecl,
    importc: "dRFromZAxis", dynlib: odedll.}
proc dQSetIdentity*(q: dQuaternion) {.cdecl, importc: "dQSetIdentity", dynlib: odedll.}
proc dQFromAxisAndAngle*(q: dQuaternion; ax: dReal; ay: dReal; az: dReal; angle: dReal) {.
    cdecl, importc: "dQFromAxisAndAngle", dynlib: odedll.}
proc dQMultiply0*(qa: dQuaternion; qb: dQuaternion; qc: dQuaternion) {.cdecl,
    importc: "dQMultiply0", dynlib: odedll.}
proc dQMultiply1*(qa: dQuaternion; qb: dQuaternion; qc: dQuaternion) {.cdecl,
    importc: "dQMultiply1", dynlib: odedll.}
proc dQMultiply2*(qa: dQuaternion; qb: dQuaternion; qc: dQuaternion) {.cdecl,
    importc: "dQMultiply2", dynlib: odedll.}
proc dQMultiply3*(qa: dQuaternion; qb: dQuaternion; qc: dQuaternion) {.cdecl,
    importc: "dQMultiply3", dynlib: odedll.}
proc dRfromQ*(R: dMatrix3; q: dQuaternion) {.cdecl, importc: "dRfromQ", dynlib: odedll.}
proc dQfromR*(q: dQuaternion; R: dMatrix3) {.cdecl, importc: "dQfromR", dynlib: odedll.}
proc dDQfromW*(dq: array[4, dReal]; w: dVector3; q: dQuaternion) {.cdecl,
    importc: "dDQfromW", dynlib: odedll.}
proc dMassCheck*(m: ptr dMass): cint {.cdecl, importc: "dMassCheck", dynlib: odedll.}
proc dMassSetZero*(a1: ptr dMass) {.cdecl, importc: "dMassSetZero", dynlib: odedll.}
proc dMassSetParameters*(a1: ptr dMass; themass: dReal; cgx: dReal; cgy: dReal;
                        cgz: dReal; I11: dReal; I22: dReal; I33: dReal; I12: dReal;
                        I13: dReal; I23: dReal) {.cdecl,
    importc: "dMassSetParameters", dynlib: odedll.}
proc dMassSetSphere*(a1: ptr dMass; density: dReal; radius: dReal) {.cdecl,
    importc: "dMassSetSphere", dynlib: odedll.}
proc dMassSetSphereTotal*(a1: ptr dMass; total_mass: dReal; radius: dReal) {.cdecl,
    importc: "dMassSetSphereTotal", dynlib: odedll.}
proc dMassSetCapsule*(a1: ptr dMass; density: dReal; direction: cint; radius: dReal;
                     length: dReal) {.cdecl, importc: "dMassSetCapsule",
                                    dynlib: odedll.}
proc dMassSetCapsuleTotal*(a1: ptr dMass; total_mass: dReal; direction: cint;
                          radius: dReal; length: dReal) {.cdecl,
    importc: "dMassSetCapsuleTotal", dynlib: odedll.}
proc dMassSetCylinder*(a1: ptr dMass; density: dReal; direction: cint; radius: dReal;
                      length: dReal) {.cdecl, importc: "dMassSetCylinder",
                                     dynlib: odedll.}
proc dMassSetCylinderTotal*(a1: ptr dMass; total_mass: dReal; direction: cint;
                           radius: dReal; length: dReal) {.cdecl,
    importc: "dMassSetCylinderTotal", dynlib: odedll.}
proc dMassSetBox*(a1: ptr dMass; density: dReal; lx: dReal; ly: dReal; lz: dReal) {.cdecl,
    importc: "dMassSetBox", dynlib: odedll.}
proc dMassSetBoxTotal*(a1: ptr dMass; total_mass: dReal; lx: dReal; ly: dReal; lz: dReal) {.
    cdecl, importc: "dMassSetBoxTotal", dynlib: odedll.}
proc dMassSetTrimesh*(a1: ptr dMass; density: dReal; g: dGeomID) {.cdecl,
    importc: "dMassSetTrimesh", dynlib: odedll.}
proc dMassSetTrimeshTotal*(m: ptr dMass; total_mass: dReal; g: dGeomID) {.cdecl,
    importc: "dMassSetTrimeshTotal", dynlib: odedll.}
proc dMassAdjust*(a1: ptr dMass; newmass: dReal) {.cdecl, importc: "dMassAdjust",
    dynlib: odedll.}
proc dMassTranslate*(a1: ptr dMass; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dMassTranslate", dynlib: odedll.}
proc dMassRotate*(a1: ptr dMass; R: dMatrix3) {.cdecl, importc: "dMassRotate",
    dynlib: odedll.}
proc dMassAdd*(a: ptr dMass; b: ptr dMass) {.cdecl, importc: "dMassAdd", dynlib: odedll.}
proc dTestRand*(): cint {.cdecl, importc: "dTestRand", dynlib: odedll.}
proc dRand*(): culong {.cdecl, importc: "dRand", dynlib: odedll.}
proc dRandGetSeed*(): culong {.cdecl, importc: "dRandGetSeed", dynlib: odedll.}
proc dRandSetSeed*(s: culong) {.cdecl, importc: "dRandSetSeed", dynlib: odedll.}
proc dRandInt*(n: cint): cint {.cdecl, importc: "dRandInt", dynlib: odedll.}
proc dRandReal*(): dReal {.cdecl, importc: "dRandReal", dynlib: odedll.}
proc dPrintMatrix*(A: ptr dReal; n: cint; m: cint; fmt: cstring; f: ptr FILE) {.cdecl,
    importc: "dPrintMatrix", dynlib: odedll.}
proc dMakeRandomVector*(A: ptr dReal; n: cint; range: dReal) {.cdecl,
    importc: "dMakeRandomVector", dynlib: odedll.}
proc dMakeRandomMatrix*(A: ptr dReal; n: cint; m: cint; range: dReal) {.cdecl,
    importc: "dMakeRandomMatrix", dynlib: odedll.}
proc dClearUpperTriangle*(A: ptr dReal; n: cint) {.cdecl,
    importc: "dClearUpperTriangle", dynlib: odedll.}
proc dMaxDifference*(A: ptr dReal; B: ptr dReal; n: cint; m: cint): dReal {.cdecl,
    importc: "dMaxDifference", dynlib: odedll.}
proc dMaxDifferenceLowerTriangle*(A: ptr dReal; B: ptr dReal; n: cint): dReal {.cdecl,
    importc: "dMaxDifferenceLowerTriangle", dynlib: odedll.}
proc dWorldCreate*(): dWorldID {.cdecl, importc: "dWorldCreate", dynlib: odedll.}
proc dWorldDestroy*(world: dWorldID) {.cdecl, importc: "dWorldDestroy", dynlib: odedll.}
proc dWorldSetData*(world: dWorldID; data: pointer) {.cdecl, importc: "dWorldSetData",
    dynlib: odedll.}
proc dWorldGetData*(world: dWorldID): pointer {.cdecl, importc: "dWorldGetData",
    dynlib: odedll.}
proc dWorldSetGravity*(a1: dWorldID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dWorldSetGravity", dynlib: odedll.}
proc dWorldGetGravity*(a1: dWorldID; gravity: dVector3) {.cdecl,
    importc: "dWorldGetGravity", dynlib: odedll.}
proc dWorldSetERP*(a1: dWorldID; erp: dReal) {.cdecl, importc: "dWorldSetERP",
    dynlib: odedll.}
proc dWorldGetERP*(a1: dWorldID): dReal {.cdecl, importc: "dWorldGetERP",
                                      dynlib: odedll.}
proc dWorldSetCFM*(a1: dWorldID; cfm: dReal) {.cdecl, importc: "dWorldSetCFM",
    dynlib: odedll.}
proc dWorldGetCFM*(a1: dWorldID): dReal {.cdecl, importc: "dWorldGetCFM",
                                      dynlib: odedll.}
proc dWorldSetStepIslandsProcessingMaxThreadCount*(w: dWorldID; count: cuint) {.
    cdecl, importc: "dWorldSetStepIslandsProcessingMaxThreadCount", dynlib: odedll.}
proc dWorldGetStepIslandsProcessingMaxThreadCount*(w: dWorldID): cuint {.cdecl,
    importc: "dWorldGetStepIslandsProcessingMaxThreadCount", dynlib: odedll.}
proc dWorldUseSharedWorkingMemory*(w: dWorldID; from_world: dWorldID): cint {.cdecl,
    importc: "dWorldUseSharedWorkingMemory", dynlib: odedll.}
  ## =NULL
proc dWorldCleanupWorkingMemory*(w: dWorldID) {.cdecl,
    importc: "dWorldCleanupWorkingMemory", dynlib: odedll.}
proc dWorldSetStepMemoryReservationPolicy*(w: dWorldID; policyinfo: ptr dWorldStepReserveInfo): cint {.
    cdecl, importc: "dWorldSetStepMemoryReservationPolicy", dynlib: odedll.}
  ## =NULL
proc dWorldSetStepMemoryManager*(w: dWorldID;
                                memfuncs: ptr dWorldStepMemoryFunctionsInfo): cint {.
    cdecl, importc: "dWorldSetStepMemoryManager", dynlib: odedll.}
proc dWorldSetStepThreadingImplementation*(w: dWorldID;
    functions_info: ptr dThreadingFunctionsInfo;
    threading_impl: dThreadingImplementationID) {.cdecl,
    importc: "dWorldSetStepThreadingImplementation", dynlib: odedll.}
proc dWorldStep*(w: dWorldID; stepsize: dReal): cint {.cdecl, importc: "dWorldStep",
    dynlib: odedll.}
proc dWorldQuickStep*(w: dWorldID; stepsize: dReal): cint {.cdecl,
    importc: "dWorldQuickStep", dynlib: odedll.}
proc dWorldImpulseToForce*(a1: dWorldID; stepsize: dReal; ix: dReal; iy: dReal;
                          iz: dReal; force: dVector3) {.cdecl,
    importc: "dWorldImpulseToForce", dynlib: odedll.}
proc dWorldSetQuickStepNumIterations*(w: dWorldID; num: cint) {.cdecl,
    importc: "dWorldSetQuickStepNumIterations", dynlib: odedll.}
proc dWorldGetQuickStepNumIterations*(a1: dWorldID): cint {.cdecl,
    importc: "dWorldGetQuickStepNumIterations", dynlib: odedll.}
proc dWorldSetQuickStepDynamicIterationParameters*(w: dWorldID; ptr_iteration_premature_exit_delta: ptr dReal; ## =NULL
    ptr_max_num_extra_factor: ptr dReal; ## =NULL
    ptr_extra_iteration_requirement_delta: ptr dReal) {.cdecl,
    importc: "dWorldSetQuickStepDynamicIterationParameters", dynlib: odedll.}
  ## =NULL
proc dWorldGetQuickStepDynamicIterationParameters*(w: dWorldID; out_iteration_premature_exit_delta: ptr dReal; ## =NULL
    out_max_num_extra_factor: ptr dReal; ## =NULL
    out_extra_iteration_requirement_delta: ptr dReal) {.cdecl,
    importc: "dWorldGetQuickStepDynamicIterationParameters", dynlib: odedll.}
  ## =NULL
proc dWorldAttachQuickStepDynamicIterationStatisticsSink*(w: dWorldID; var_stats: ptr dWorldQuickStepIterationCount_DynamicAdjustmentStatistics): cint {.
    cdecl, importc: "dWorldAttachQuickStepDynamicIterationStatisticsSink",
    dynlib: odedll.}
  ## =NULL
proc dWorldSetQuickStepW*(a1: dWorldID; over_relaxation: dReal) {.cdecl,
    importc: "dWorldSetQuickStepW", dynlib: odedll.}
proc dWorldGetQuickStepW*(a1: dWorldID): dReal {.cdecl,
    importc: "dWorldGetQuickStepW", dynlib: odedll.}
proc dWorldSetContactMaxCorrectingVel*(a1: dWorldID; vel: dReal) {.cdecl,
    importc: "dWorldSetContactMaxCorrectingVel", dynlib: odedll.}
proc dWorldGetContactMaxCorrectingVel*(a1: dWorldID): dReal {.cdecl,
    importc: "dWorldGetContactMaxCorrectingVel", dynlib: odedll.}
proc dWorldSetContactSurfaceLayer*(a1: dWorldID; depth: dReal) {.cdecl,
    importc: "dWorldSetContactSurfaceLayer", dynlib: odedll.}
proc dWorldGetContactSurfaceLayer*(a1: dWorldID): dReal {.cdecl,
    importc: "dWorldGetContactSurfaceLayer", dynlib: odedll.}
proc dWorldGetAutoDisableLinearThreshold*(a1: dWorldID): dReal {.cdecl,
    importc: "dWorldGetAutoDisableLinearThreshold", dynlib: odedll.}
proc dWorldSetAutoDisableLinearThreshold*(a1: dWorldID;
    linear_average_threshold: dReal) {.cdecl, importc: "dWorldSetAutoDisableLinearThreshold",
                                     dynlib: odedll.}
proc dWorldGetAutoDisableAngularThreshold*(a1: dWorldID): dReal {.cdecl,
    importc: "dWorldGetAutoDisableAngularThreshold", dynlib: odedll.}
proc dWorldSetAutoDisableAngularThreshold*(a1: dWorldID;
    angular_average_threshold: dReal) {.cdecl, importc: "dWorldSetAutoDisableAngularThreshold",
                                      dynlib: odedll.}
proc dWorldGetAutoDisableAverageSamplesCount*(a1: dWorldID): cint {.cdecl,
    importc: "dWorldGetAutoDisableAverageSamplesCount", dynlib: odedll.}
proc dWorldSetAutoDisableAverageSamplesCount*(a1: dWorldID;
    average_samples_count: cuint) {.cdecl, importc: "dWorldSetAutoDisableAverageSamplesCount",
                                  dynlib: odedll.}
proc dWorldGetAutoDisableSteps*(a1: dWorldID): cint {.cdecl,
    importc: "dWorldGetAutoDisableSteps", dynlib: odedll.}
proc dWorldSetAutoDisableSteps*(a1: dWorldID; steps: cint) {.cdecl,
    importc: "dWorldSetAutoDisableSteps", dynlib: odedll.}
proc dWorldGetAutoDisableTime*(a1: dWorldID): dReal {.cdecl,
    importc: "dWorldGetAutoDisableTime", dynlib: odedll.}
proc dWorldSetAutoDisableTime*(a1: dWorldID; time: dReal) {.cdecl,
    importc: "dWorldSetAutoDisableTime", dynlib: odedll.}
proc dWorldGetAutoDisableFlag*(a1: dWorldID): cint {.cdecl,
    importc: "dWorldGetAutoDisableFlag", dynlib: odedll.}
proc dWorldSetAutoDisableFlag*(a1: dWorldID; do_auto_disable: cint) {.cdecl,
    importc: "dWorldSetAutoDisableFlag", dynlib: odedll.}
proc dWorldGetLinearDampingThreshold*(w: dWorldID): dReal {.cdecl,
    importc: "dWorldGetLinearDampingThreshold", dynlib: odedll.}
proc dWorldSetLinearDampingThreshold*(w: dWorldID; threshold: dReal) {.cdecl,
    importc: "dWorldSetLinearDampingThreshold", dynlib: odedll.}
proc dWorldGetAngularDampingThreshold*(w: dWorldID): dReal {.cdecl,
    importc: "dWorldGetAngularDampingThreshold", dynlib: odedll.}
proc dWorldSetAngularDampingThreshold*(w: dWorldID; threshold: dReal) {.cdecl,
    importc: "dWorldSetAngularDampingThreshold", dynlib: odedll.}
proc dWorldGetLinearDamping*(w: dWorldID): dReal {.cdecl,
    importc: "dWorldGetLinearDamping", dynlib: odedll.}
proc dWorldSetLinearDamping*(w: dWorldID; scale: dReal) {.cdecl,
    importc: "dWorldSetLinearDamping", dynlib: odedll.}
proc dWorldGetAngularDamping*(w: dWorldID): dReal {.cdecl,
    importc: "dWorldGetAngularDamping", dynlib: odedll.}
proc dWorldSetAngularDamping*(w: dWorldID; scale: dReal) {.cdecl,
    importc: "dWorldSetAngularDamping", dynlib: odedll.}
proc dWorldSetDamping*(w: dWorldID; linear_scale: dReal; angular_scale: dReal) {.cdecl,
    importc: "dWorldSetDamping", dynlib: odedll.}
proc dWorldGetMaxAngularSpeed*(w: dWorldID): dReal {.cdecl,
    importc: "dWorldGetMaxAngularSpeed", dynlib: odedll.}
proc dWorldSetMaxAngularSpeed*(w: dWorldID; max_speed: dReal) {.cdecl,
    importc: "dWorldSetMaxAngularSpeed", dynlib: odedll.}
proc dBodyGetAutoDisableLinearThreshold*(a1: dBodyID): dReal {.cdecl,
    importc: "dBodyGetAutoDisableLinearThreshold", dynlib: odedll.}
proc dBodySetAutoDisableLinearThreshold*(a1: dBodyID;
                                        linear_average_threshold: dReal) {.cdecl,
    importc: "dBodySetAutoDisableLinearThreshold", dynlib: odedll.}
proc dBodyGetAutoDisableAngularThreshold*(a1: dBodyID): dReal {.cdecl,
    importc: "dBodyGetAutoDisableAngularThreshold", dynlib: odedll.}
proc dBodySetAutoDisableAngularThreshold*(a1: dBodyID;
    angular_average_threshold: dReal) {.cdecl, importc: "dBodySetAutoDisableAngularThreshold",
                                      dynlib: odedll.}
proc dBodyGetAutoDisableAverageSamplesCount*(a1: dBodyID): cint {.cdecl,
    importc: "dBodyGetAutoDisableAverageSamplesCount", dynlib: odedll.}
proc dBodySetAutoDisableAverageSamplesCount*(a1: dBodyID;
    average_samples_count: cuint) {.cdecl, importc: "dBodySetAutoDisableAverageSamplesCount",
                                  dynlib: odedll.}
proc dBodyGetAutoDisableSteps*(a1: dBodyID): cint {.cdecl,
    importc: "dBodyGetAutoDisableSteps", dynlib: odedll.}
proc dBodySetAutoDisableSteps*(a1: dBodyID; steps: cint) {.cdecl,
    importc: "dBodySetAutoDisableSteps", dynlib: odedll.}
proc dBodyGetAutoDisableTime*(a1: dBodyID): dReal {.cdecl,
    importc: "dBodyGetAutoDisableTime", dynlib: odedll.}
proc dBodySetAutoDisableTime*(a1: dBodyID; time: dReal) {.cdecl,
    importc: "dBodySetAutoDisableTime", dynlib: odedll.}
proc dBodyGetAutoDisableFlag*(a1: dBodyID): cint {.cdecl,
    importc: "dBodyGetAutoDisableFlag", dynlib: odedll.}
proc dBodySetAutoDisableFlag*(a1: dBodyID; do_auto_disable: cint) {.cdecl,
    importc: "dBodySetAutoDisableFlag", dynlib: odedll.}
proc dBodySetAutoDisableDefaults*(a1: dBodyID) {.cdecl,
    importc: "dBodySetAutoDisableDefaults", dynlib: odedll.}
proc dBodyGetWorld*(a1: dBodyID): dWorldID {.cdecl, importc: "dBodyGetWorld",
    dynlib: odedll.}
proc dBodyCreate*(a1: dWorldID): dBodyID {.cdecl, importc: "dBodyCreate",
                                       dynlib: odedll.}
proc dBodyDestroy*(a1: dBodyID) {.cdecl, importc: "dBodyDestroy", dynlib: odedll.}
proc dBodySetData*(a1: dBodyID; data: pointer) {.cdecl, importc: "dBodySetData",
    dynlib: odedll.}
proc dBodyGetData*(a1: dBodyID): pointer {.cdecl, importc: "dBodyGetData",
                                       dynlib: odedll.}
proc dBodySetPosition*(a1: dBodyID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dBodySetPosition", dynlib: odedll.}
proc dBodySetRotation*(a1: dBodyID; R: dMatrix3) {.cdecl, importc: "dBodySetRotation",
    dynlib: odedll.}
proc dBodySetQuaternion*(a1: dBodyID; q: dQuaternion) {.cdecl,
    importc: "dBodySetQuaternion", dynlib: odedll.}
proc dBodySetLinearVel*(a1: dBodyID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dBodySetLinearVel", dynlib: odedll.}
proc dBodySetAngularVel*(a1: dBodyID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dBodySetAngularVel", dynlib: odedll.}
proc dBodyGetPosition*(a1: dBodyID): ptr dReal {.cdecl, importc: "dBodyGetPosition",
    dynlib: odedll.}
proc dBodyCopyPosition*(body: dBodyID; pos: dVector3) {.cdecl,
    importc: "dBodyCopyPosition", dynlib: odedll.}
proc dBodyGetRotation*(a1: dBodyID): ptr dReal {.cdecl, importc: "dBodyGetRotation",
    dynlib: odedll.}
proc dBodyCopyRotation*(a1: dBodyID; R: dMatrix3) {.cdecl,
    importc: "dBodyCopyRotation", dynlib: odedll.}
proc dBodyGetQuaternion*(a1: dBodyID): ptr dReal {.cdecl,
    importc: "dBodyGetQuaternion", dynlib: odedll.}
proc dBodyCopyQuaternion*(body: dBodyID; quat: dQuaternion) {.cdecl,
    importc: "dBodyCopyQuaternion", dynlib: odedll.}
proc dBodyGetLinearVel*(a1: dBodyID): ptr dReal {.cdecl, importc: "dBodyGetLinearVel",
    dynlib: odedll.}
proc dBodyGetAngularVel*(a1: dBodyID): ptr dReal {.cdecl,
    importc: "dBodyGetAngularVel", dynlib: odedll.}
proc dBodySetMass*(a1: dBodyID; mass: ptr dMass) {.cdecl, importc: "dBodySetMass",
    dynlib: odedll.}
proc dBodyGetMass*(a1: dBodyID; mass: ptr dMass) {.cdecl, importc: "dBodyGetMass",
    dynlib: odedll.}
proc dBodyAddForce*(a1: dBodyID; fx: dReal; fy: dReal; fz: dReal) {.cdecl,
    importc: "dBodyAddForce", dynlib: odedll.}
proc dBodyAddTorque*(a1: dBodyID; fx: dReal; fy: dReal; fz: dReal) {.cdecl,
    importc: "dBodyAddTorque", dynlib: odedll.}
proc dBodyAddRelForce*(a1: dBodyID; fx: dReal; fy: dReal; fz: dReal) {.cdecl,
    importc: "dBodyAddRelForce", dynlib: odedll.}
proc dBodyAddRelTorque*(a1: dBodyID; fx: dReal; fy: dReal; fz: dReal) {.cdecl,
    importc: "dBodyAddRelTorque", dynlib: odedll.}
proc dBodyAddForceAtPos*(a1: dBodyID; fx: dReal; fy: dReal; fz: dReal; px: dReal;
                        py: dReal; pz: dReal) {.cdecl, importc: "dBodyAddForceAtPos",
    dynlib: odedll.}
proc dBodyAddForceAtRelPos*(a1: dBodyID; fx: dReal; fy: dReal; fz: dReal; px: dReal;
                           py: dReal; pz: dReal) {.cdecl,
    importc: "dBodyAddForceAtRelPos", dynlib: odedll.}
proc dBodyAddRelForceAtPos*(a1: dBodyID; fx: dReal; fy: dReal; fz: dReal; px: dReal;
                           py: dReal; pz: dReal) {.cdecl,
    importc: "dBodyAddRelForceAtPos", dynlib: odedll.}
proc dBodyAddRelForceAtRelPos*(a1: dBodyID; fx: dReal; fy: dReal; fz: dReal; px: dReal;
                              py: dReal; pz: dReal) {.cdecl,
    importc: "dBodyAddRelForceAtRelPos", dynlib: odedll.}
proc dBodyGetForce*(a1: dBodyID): ptr dReal {.cdecl, importc: "dBodyGetForce",
    dynlib: odedll.}
proc dBodyGetTorque*(a1: dBodyID): ptr dReal {.cdecl, importc: "dBodyGetTorque",
    dynlib: odedll.}
proc dBodySetForce*(b: dBodyID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dBodySetForce", dynlib: odedll.}
proc dBodySetTorque*(b: dBodyID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dBodySetTorque", dynlib: odedll.}
proc dBodyGetRelPointPos*(a1: dBodyID; px: dReal; py: dReal; pz: dReal; result: dVector3) {.
    cdecl, importc: "dBodyGetRelPointPos", dynlib: odedll.}
proc dBodyGetRelPointVel*(a1: dBodyID; px: dReal; py: dReal; pz: dReal; result: dVector3) {.
    cdecl, importc: "dBodyGetRelPointVel", dynlib: odedll.}
proc dBodyGetPointVel*(a1: dBodyID; px: dReal; py: dReal; pz: dReal; result: dVector3) {.
    cdecl, importc: "dBodyGetPointVel", dynlib: odedll.}
proc dBodyGetPosRelPoint*(a1: dBodyID; px: dReal; py: dReal; pz: dReal; result: dVector3) {.
    cdecl, importc: "dBodyGetPosRelPoint", dynlib: odedll.}
proc dBodyVectorToWorld*(a1: dBodyID; px: dReal; py: dReal; pz: dReal; result: dVector3) {.
    cdecl, importc: "dBodyVectorToWorld", dynlib: odedll.}
proc dBodyVectorFromWorld*(a1: dBodyID; px: dReal; py: dReal; pz: dReal; result: dVector3) {.
    cdecl, importc: "dBodyVectorFromWorld", dynlib: odedll.}
proc dBodySetFiniteRotationMode*(a1: dBodyID; mode: cint) {.cdecl,
    importc: "dBodySetFiniteRotationMode", dynlib: odedll.}
proc dBodySetFiniteRotationAxis*(a1: dBodyID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dBodySetFiniteRotationAxis", dynlib: odedll.}
proc dBodyGetFiniteRotationMode*(a1: dBodyID): cint {.cdecl,
    importc: "dBodyGetFiniteRotationMode", dynlib: odedll.}
proc dBodyGetFiniteRotationAxis*(a1: dBodyID; result: dVector3) {.cdecl,
    importc: "dBodyGetFiniteRotationAxis", dynlib: odedll.}
proc dBodyGetNumJoints*(b: dBodyID): cint {.cdecl, importc: "dBodyGetNumJoints",
                                        dynlib: odedll.}
proc dBodyGetJoint*(a1: dBodyID; index: cint): dJointID {.cdecl,
    importc: "dBodyGetJoint", dynlib: odedll.}
proc dBodySetDynamic*(a1: dBodyID) {.cdecl, importc: "dBodySetDynamic", dynlib: odedll.}
proc dBodySetKinematic*(a1: dBodyID) {.cdecl, importc: "dBodySetKinematic",
                                    dynlib: odedll.}
proc dBodyIsKinematic*(a1: dBodyID): cint {.cdecl, importc: "dBodyIsKinematic",
                                        dynlib: odedll.}
proc dBodyEnable*(a1: dBodyID) {.cdecl, importc: "dBodyEnable", dynlib: odedll.}
proc dBodyDisable*(a1: dBodyID) {.cdecl, importc: "dBodyDisable", dynlib: odedll.}
proc dBodyIsEnabled*(a1: dBodyID): cint {.cdecl, importc: "dBodyIsEnabled",
                                      dynlib: odedll.}
proc dBodySetGravityMode*(b: dBodyID; mode: cint) {.cdecl,
    importc: "dBodySetGravityMode", dynlib: odedll.}
proc dBodyGetGravityMode*(b: dBodyID): cint {.cdecl, importc: "dBodyGetGravityMode",
    dynlib: odedll.}
proc dBodySetMovedCallback*(b: dBodyID; callback: proc (a1: dBodyID) {.cdecl.}) {.cdecl,
    importc: "dBodySetMovedCallback", dynlib: odedll.}
proc dBodyGetFirstGeom*(b: dBodyID): dGeomID {.cdecl, importc: "dBodyGetFirstGeom",
    dynlib: odedll.}
proc dBodyGetNextGeom*(g: dGeomID): dGeomID {.cdecl, importc: "dBodyGetNextGeom",
    dynlib: odedll.}
proc dBodySetDampingDefaults*(b: dBodyID) {.cdecl,
    importc: "dBodySetDampingDefaults", dynlib: odedll.}
proc dBodyGetLinearDamping*(b: dBodyID): dReal {.cdecl,
    importc: "dBodyGetLinearDamping", dynlib: odedll.}
proc dBodySetLinearDamping*(b: dBodyID; scale: dReal) {.cdecl,
    importc: "dBodySetLinearDamping", dynlib: odedll.}
proc dBodyGetAngularDamping*(b: dBodyID): dReal {.cdecl,
    importc: "dBodyGetAngularDamping", dynlib: odedll.}
proc dBodySetAngularDamping*(b: dBodyID; scale: dReal) {.cdecl,
    importc: "dBodySetAngularDamping", dynlib: odedll.}
proc dBodySetDamping*(b: dBodyID; linear_scale: dReal; angular_scale: dReal) {.cdecl,
    importc: "dBodySetDamping", dynlib: odedll.}
proc dBodyGetLinearDampingThreshold*(b: dBodyID): dReal {.cdecl,
    importc: "dBodyGetLinearDampingThreshold", dynlib: odedll.}
proc dBodySetLinearDampingThreshold*(b: dBodyID; threshold: dReal) {.cdecl,
    importc: "dBodySetLinearDampingThreshold", dynlib: odedll.}
proc dBodyGetAngularDampingThreshold*(b: dBodyID): dReal {.cdecl,
    importc: "dBodyGetAngularDampingThreshold", dynlib: odedll.}
proc dBodySetAngularDampingThreshold*(b: dBodyID; threshold: dReal) {.cdecl,
    importc: "dBodySetAngularDampingThreshold", dynlib: odedll.}
proc dBodyGetMaxAngularSpeed*(b: dBodyID): dReal {.cdecl,
    importc: "dBodyGetMaxAngularSpeed", dynlib: odedll.}
proc dBodySetMaxAngularSpeed*(b: dBodyID; max_speed: dReal) {.cdecl,
    importc: "dBodySetMaxAngularSpeed", dynlib: odedll.}
proc dBodyGetGyroscopicMode*(b: dBodyID): cint {.cdecl,
    importc: "dBodyGetGyroscopicMode", dynlib: odedll.}
proc dBodySetGyroscopicMode*(b: dBodyID; enabled: cint) {.cdecl,
    importc: "dBodySetGyroscopicMode", dynlib: odedll.}
proc dJointCreateBall*(a1: dWorldID; a2: dJointGroupID): dJointID {.cdecl,
    importc: "dJointCreateBall", dynlib: odedll.}
proc dJointCreateHinge*(a1: dWorldID; a2: dJointGroupID): dJointID {.cdecl,
    importc: "dJointCreateHinge", dynlib: odedll.}
proc dJointCreateSlider*(a1: dWorldID; a2: dJointGroupID): dJointID {.cdecl,
    importc: "dJointCreateSlider", dynlib: odedll.}
proc dJointCreateContact*(a1: dWorldID; a2: dJointGroupID; a3: ptr dContact): dJointID {.
    cdecl, importc: "dJointCreateContact", dynlib: odedll.}
proc dJointCreateHinge2*(a1: dWorldID; a2: dJointGroupID): dJointID {.cdecl,
    importc: "dJointCreateHinge2", dynlib: odedll.}
proc dJointCreateUniversal*(a1: dWorldID; a2: dJointGroupID): dJointID {.cdecl,
    importc: "dJointCreateUniversal", dynlib: odedll.}
proc dJointCreatePR*(a1: dWorldID; a2: dJointGroupID): dJointID {.cdecl,
    importc: "dJointCreatePR", dynlib: odedll.}
proc dJointCreatePU*(a1: dWorldID; a2: dJointGroupID): dJointID {.cdecl,
    importc: "dJointCreatePU", dynlib: odedll.}
proc dJointCreatePiston*(a1: dWorldID; a2: dJointGroupID): dJointID {.cdecl,
    importc: "dJointCreatePiston", dynlib: odedll.}
proc dJointCreateFixed*(a1: dWorldID; a2: dJointGroupID): dJointID {.cdecl,
    importc: "dJointCreateFixed", dynlib: odedll.}
proc dJointCreateNull*(a1: dWorldID; a2: dJointGroupID): dJointID {.cdecl,
    importc: "dJointCreateNull", dynlib: odedll.}
proc dJointCreateAMotor*(a1: dWorldID; a2: dJointGroupID): dJointID {.cdecl,
    importc: "dJointCreateAMotor", dynlib: odedll.}
proc dJointCreateLMotor*(a1: dWorldID; a2: dJointGroupID): dJointID {.cdecl,
    importc: "dJointCreateLMotor", dynlib: odedll.}
proc dJointCreatePlane2D*(a1: dWorldID; a2: dJointGroupID): dJointID {.cdecl,
    importc: "dJointCreatePlane2D", dynlib: odedll.}
proc dJointCreateDBall*(a1: dWorldID; a2: dJointGroupID): dJointID {.cdecl,
    importc: "dJointCreateDBall", dynlib: odedll.}
proc dJointCreateDHinge*(a1: dWorldID; a2: dJointGroupID): dJointID {.cdecl,
    importc: "dJointCreateDHinge", dynlib: odedll.}
proc dJointCreateTransmission*(a1: dWorldID; a2: dJointGroupID): dJointID {.cdecl,
    importc: "dJointCreateTransmission", dynlib: odedll.}
proc dJointDestroy*(a1: dJointID) {.cdecl, importc: "dJointDestroy", dynlib: odedll.}
proc dJointGroupCreate*(max_size: cint): dJointGroupID {.cdecl,
    importc: "dJointGroupCreate", dynlib: odedll.}
proc dJointGroupDestroy*(a1: dJointGroupID) {.cdecl, importc: "dJointGroupDestroy",
    dynlib: odedll.}
proc dJointGroupEmpty*(a1: dJointGroupID) {.cdecl, importc: "dJointGroupEmpty",
    dynlib: odedll.}
proc dJointGetNumBodies*(a1: dJointID): cint {.cdecl, importc: "dJointGetNumBodies",
    dynlib: odedll.}
proc dJointAttach*(a1: dJointID; body1: dBodyID; body2: dBodyID) {.cdecl,
    importc: "dJointAttach", dynlib: odedll.}
proc dJointEnable*(a1: dJointID) {.cdecl, importc: "dJointEnable", dynlib: odedll.}
proc dJointDisable*(a1: dJointID) {.cdecl, importc: "dJointDisable", dynlib: odedll.}
proc dJointIsEnabled*(a1: dJointID): cint {.cdecl, importc: "dJointIsEnabled",
                                        dynlib: odedll.}
proc dJointSetData*(a1: dJointID; data: pointer) {.cdecl, importc: "dJointSetData",
    dynlib: odedll.}
proc dJointGetData*(a1: dJointID): pointer {.cdecl, importc: "dJointGetData",
    dynlib: odedll.}
proc dJointGetType*(a1: dJointID): dJointType {.cdecl, importc: "dJointGetType",
    dynlib: odedll.}
proc dJointGetBody*(a1: dJointID; index: cint): dBodyID {.cdecl,
    importc: "dJointGetBody", dynlib: odedll.}
proc dJointSetFeedback*(a1: dJointID; a2: ptr dJointFeedback) {.cdecl,
    importc: "dJointSetFeedback", dynlib: odedll.}
proc dJointGetFeedback*(a1: dJointID): ptr dJointFeedback {.cdecl,
    importc: "dJointGetFeedback", dynlib: odedll.}
proc dJointSetBallAnchor*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetBallAnchor", dynlib: odedll.}
proc dJointSetBallAnchor2*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetBallAnchor2", dynlib: odedll.}
proc dJointSetBallParam*(a1: dJointID; parameter: cint; value: dReal) {.cdecl,
    importc: "dJointSetBallParam", dynlib: odedll.}
proc dJointSetHingeAnchor*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetHingeAnchor", dynlib: odedll.}
proc dJointSetHingeAnchorDelta*(a1: dJointID; x: dReal; y: dReal; z: dReal; ax: dReal;
                               ay: dReal; az: dReal) {.cdecl,
    importc: "dJointSetHingeAnchorDelta", dynlib: odedll.}
proc dJointSetHingeAxis*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetHingeAxis", dynlib: odedll.}
proc dJointSetHingeAxisOffset*(j: dJointID; x: dReal; y: dReal; z: dReal; angle: dReal) {.
    cdecl, importc: "dJointSetHingeAxisOffset", dynlib: odedll.}
proc dJointSetHingeParam*(a1: dJointID; parameter: cint; value: dReal) {.cdecl,
    importc: "dJointSetHingeParam", dynlib: odedll.}
proc dJointAddHingeTorque*(joint: dJointID; torque: dReal) {.cdecl,
    importc: "dJointAddHingeTorque", dynlib: odedll.}
proc dJointSetSliderAxis*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetSliderAxis", dynlib: odedll.}
proc dJointSetSliderAxisDelta*(a1: dJointID; x: dReal; y: dReal; z: dReal; ax: dReal;
                              ay: dReal; az: dReal) {.cdecl,
    importc: "dJointSetSliderAxisDelta", dynlib: odedll.}
proc dJointSetSliderParam*(a1: dJointID; parameter: cint; value: dReal) {.cdecl,
    importc: "dJointSetSliderParam", dynlib: odedll.}
proc dJointAddSliderForce*(joint: dJointID; force: dReal) {.cdecl,
    importc: "dJointAddSliderForce", dynlib: odedll.}
proc dJointSetHinge2Anchor*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetHinge2Anchor", dynlib: odedll.}
proc dJointSetHinge2Axes*(j: dJointID; axis1: ptr dReal; ## =[dSA__MAX],=NULL
                         axis2: ptr dReal) {.cdecl, importc: "dJointSetHinge2Axes",
    dynlib: odedll.}
  ## =[dSA__MAX],=NULL
proc dJointSetHinge2Param*(a1: dJointID; parameter: cint; value: dReal) {.cdecl,
    importc: "dJointSetHinge2Param", dynlib: odedll.}
proc dJointAddHinge2Torques*(joint: dJointID; torque1: dReal; torque2: dReal) {.cdecl,
    importc: "dJointAddHinge2Torques", dynlib: odedll.}
proc dJointSetUniversalAnchor*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetUniversalAnchor", dynlib: odedll.}
proc dJointSetUniversalAxis1*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetUniversalAxis1", dynlib: odedll.}
proc dJointSetUniversalAxis1Offset*(a1: dJointID; x: dReal; y: dReal; z: dReal;
                                   offset1: dReal; offset2: dReal) {.cdecl,
    importc: "dJointSetUniversalAxis1Offset", dynlib: odedll.}
proc dJointSetUniversalAxis2*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetUniversalAxis2", dynlib: odedll.}
proc dJointSetUniversalAxis2Offset*(a1: dJointID; x: dReal; y: dReal; z: dReal;
                                   offset1: dReal; offset2: dReal) {.cdecl,
    importc: "dJointSetUniversalAxis2Offset", dynlib: odedll.}
proc dJointSetUniversalParam*(a1: dJointID; parameter: cint; value: dReal) {.cdecl,
    importc: "dJointSetUniversalParam", dynlib: odedll.}
proc dJointAddUniversalTorques*(joint: dJointID; torque1: dReal; torque2: dReal) {.
    cdecl, importc: "dJointAddUniversalTorques", dynlib: odedll.}
proc dJointSetPRAnchor*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetPRAnchor", dynlib: odedll.}
proc dJointSetPRAxis1*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetPRAxis1", dynlib: odedll.}
proc dJointSetPRAxis2*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetPRAxis2", dynlib: odedll.}
proc dJointSetPRParam*(a1: dJointID; parameter: cint; value: dReal) {.cdecl,
    importc: "dJointSetPRParam", dynlib: odedll.}
proc dJointAddPRTorque*(j: dJointID; torque: dReal) {.cdecl,
    importc: "dJointAddPRTorque", dynlib: odedll.}
proc dJointSetPUAnchor*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetPUAnchor", dynlib: odedll.}
proc dJointSetPUAnchorOffset*(a1: dJointID; x: dReal; y: dReal; z: dReal; dx: dReal;
                             dy: dReal; dz: dReal) {.cdecl,
    importc: "dJointSetPUAnchorOffset", dynlib: odedll.}
proc dJointSetPUAxis1*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetPUAxis1", dynlib: odedll.}
proc dJointSetPUAxis2*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetPUAxis2", dynlib: odedll.}
proc dJointSetPUAxis3*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetPUAxis3", dynlib: odedll.}
proc dJointSetPUAxisP*(id: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetPUAxisP", dynlib: odedll.}
proc dJointSetPUParam*(a1: dJointID; parameter: cint; value: dReal) {.cdecl,
    importc: "dJointSetPUParam", dynlib: odedll.}
proc dJointAddPUTorque*(j: dJointID; torque: dReal) {.cdecl,
    importc: "dJointAddPUTorque", dynlib: odedll.}
proc dJointSetPistonAnchor*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetPistonAnchor", dynlib: odedll.}
proc dJointSetPistonAnchorOffset*(j: dJointID; x: dReal; y: dReal; z: dReal; dx: dReal;
                                 dy: dReal; dz: dReal) {.cdecl,
    importc: "dJointSetPistonAnchorOffset", dynlib: odedll.}
proc dJointSetPistonAxis*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetPistonAxis", dynlib: odedll.}
proc dJointSetPistonParam*(a1: dJointID; parameter: cint; value: dReal) {.cdecl,
    importc: "dJointSetPistonParam", dynlib: odedll.}
proc dJointAddPistonForce*(joint: dJointID; force: dReal) {.cdecl,
    importc: "dJointAddPistonForce", dynlib: odedll.}
proc dJointSetFixed*(a1: dJointID) {.cdecl, importc: "dJointSetFixed", dynlib: odedll.}
proc dJointSetFixedParam*(a1: dJointID; parameter: cint; value: dReal) {.cdecl,
    importc: "dJointSetFixedParam", dynlib: odedll.}
proc dJointSetAMotorNumAxes*(a1: dJointID; num: cint) {.cdecl,
    importc: "dJointSetAMotorNumAxes", dynlib: odedll.}
proc dJointSetAMotorAxis*(a1: dJointID; anum: cint; rel: cint; x: dReal; y: dReal; z: dReal) {.
    cdecl, importc: "dJointSetAMotorAxis", dynlib: odedll.}
proc dJointSetAMotorAngle*(a1: dJointID; anum: cint; angle: dReal) {.cdecl,
    importc: "dJointSetAMotorAngle", dynlib: odedll.}
proc dJointSetAMotorParam*(a1: dJointID; parameter: cint; value: dReal) {.cdecl,
    importc: "dJointSetAMotorParam", dynlib: odedll.}
proc dJointSetAMotorMode*(a1: dJointID; mode: cint) {.cdecl,
    importc: "dJointSetAMotorMode", dynlib: odedll.}
proc dJointAddAMotorTorques*(a1: dJointID; torque1: dReal; torque2: dReal;
                            torque3: dReal) {.cdecl,
    importc: "dJointAddAMotorTorques", dynlib: odedll.}
proc dJointSetLMotorNumAxes*(a1: dJointID; num: cint) {.cdecl,
    importc: "dJointSetLMotorNumAxes", dynlib: odedll.}
proc dJointSetLMotorAxis*(a1: dJointID; anum: cint; rel: cint; x: dReal; y: dReal; z: dReal) {.
    cdecl, importc: "dJointSetLMotorAxis", dynlib: odedll.}
proc dJointSetLMotorParam*(a1: dJointID; parameter: cint; value: dReal) {.cdecl,
    importc: "dJointSetLMotorParam", dynlib: odedll.}
proc dJointSetPlane2DXParam*(a1: dJointID; parameter: cint; value: dReal) {.cdecl,
    importc: "dJointSetPlane2DXParam", dynlib: odedll.}
proc dJointSetPlane2DYParam*(a1: dJointID; parameter: cint; value: dReal) {.cdecl,
    importc: "dJointSetPlane2DYParam", dynlib: odedll.}
proc dJointSetPlane2DAngleParam*(a1: dJointID; parameter: cint; value: dReal) {.cdecl,
    importc: "dJointSetPlane2DAngleParam", dynlib: odedll.}
proc dJointGetBallAnchor*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetBallAnchor", dynlib: odedll.}
proc dJointGetBallAnchor2*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetBallAnchor2", dynlib: odedll.}
proc dJointGetBallParam*(a1: dJointID; parameter: cint): dReal {.cdecl,
    importc: "dJointGetBallParam", dynlib: odedll.}
proc dJointGetHingeAnchor*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetHingeAnchor", dynlib: odedll.}
proc dJointGetHingeAnchor2*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetHingeAnchor2", dynlib: odedll.}
proc dJointGetHingeAxis*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetHingeAxis", dynlib: odedll.}
proc dJointGetHingeParam*(a1: dJointID; parameter: cint): dReal {.cdecl,
    importc: "dJointGetHingeParam", dynlib: odedll.}
proc dJointGetHingeAngle*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetHingeAngle", dynlib: odedll.}
proc dJointGetHingeAngleRate*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetHingeAngleRate", dynlib: odedll.}
proc dJointGetSliderPosition*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetSliderPosition", dynlib: odedll.}
proc dJointGetSliderPositionRate*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetSliderPositionRate", dynlib: odedll.}
proc dJointGetSliderAxis*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetSliderAxis", dynlib: odedll.}
proc dJointGetSliderParam*(a1: dJointID; parameter: cint): dReal {.cdecl,
    importc: "dJointGetSliderParam", dynlib: odedll.}
proc dJointGetHinge2Anchor*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetHinge2Anchor", dynlib: odedll.}
proc dJointGetHinge2Anchor2*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetHinge2Anchor2", dynlib: odedll.}
proc dJointGetHinge2Axis1*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetHinge2Axis1", dynlib: odedll.}
proc dJointGetHinge2Axis2*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetHinge2Axis2", dynlib: odedll.}
proc dJointGetHinge2Param*(a1: dJointID; parameter: cint): dReal {.cdecl,
    importc: "dJointGetHinge2Param", dynlib: odedll.}
proc dJointGetHinge2Angle1*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetHinge2Angle1", dynlib: odedll.}
proc dJointGetHinge2Angle2*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetHinge2Angle2", dynlib: odedll.}
proc dJointGetHinge2Angle1Rate*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetHinge2Angle1Rate", dynlib: odedll.}
proc dJointGetHinge2Angle2Rate*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetHinge2Angle2Rate", dynlib: odedll.}
proc dJointGetUniversalAnchor*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetUniversalAnchor", dynlib: odedll.}
proc dJointGetUniversalAnchor2*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetUniversalAnchor2", dynlib: odedll.}
proc dJointGetUniversalAxis1*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetUniversalAxis1", dynlib: odedll.}
proc dJointGetUniversalAxis2*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetUniversalAxis2", dynlib: odedll.}
proc dJointGetUniversalParam*(a1: dJointID; parameter: cint): dReal {.cdecl,
    importc: "dJointGetUniversalParam", dynlib: odedll.}
proc dJointGetUniversalAngles*(a1: dJointID; angle1: ptr dReal; angle2: ptr dReal) {.
    cdecl, importc: "dJointGetUniversalAngles", dynlib: odedll.}
proc dJointGetUniversalAngle1*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetUniversalAngle1", dynlib: odedll.}
proc dJointGetUniversalAngle2*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetUniversalAngle2", dynlib: odedll.}
proc dJointGetUniversalAngle1Rate*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetUniversalAngle1Rate", dynlib: odedll.}
proc dJointGetUniversalAngle2Rate*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetUniversalAngle2Rate", dynlib: odedll.}
proc dJointGetPRAnchor*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetPRAnchor", dynlib: odedll.}
proc dJointGetPRPosition*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetPRPosition", dynlib: odedll.}
proc dJointGetPRPositionRate*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetPRPositionRate", dynlib: odedll.}
proc dJointGetPRAngle*(a1: dJointID): dReal {.cdecl, importc: "dJointGetPRAngle",
    dynlib: odedll.}
proc dJointGetPRAngleRate*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetPRAngleRate", dynlib: odedll.}
proc dJointGetPRAxis1*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetPRAxis1", dynlib: odedll.}
proc dJointGetPRAxis2*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetPRAxis2", dynlib: odedll.}
proc dJointGetPRParam*(a1: dJointID; parameter: cint): dReal {.cdecl,
    importc: "dJointGetPRParam", dynlib: odedll.}
proc dJointGetPUAnchor*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetPUAnchor", dynlib: odedll.}
proc dJointGetPUPosition*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetPUPosition", dynlib: odedll.}
proc dJointGetPUPositionRate*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetPUPositionRate", dynlib: odedll.}
proc dJointGetPUAxis1*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetPUAxis1", dynlib: odedll.}
proc dJointGetPUAxis2*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetPUAxis2", dynlib: odedll.}
proc dJointGetPUAxis3*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetPUAxis3", dynlib: odedll.}
proc dJointGetPUAxisP*(id: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetPUAxisP", dynlib: odedll.}
proc dJointGetPUAngles*(a1: dJointID; angle1: ptr dReal; angle2: ptr dReal) {.cdecl,
    importc: "dJointGetPUAngles", dynlib: odedll.}
proc dJointGetPUAngle1*(a1: dJointID): dReal {.cdecl, importc: "dJointGetPUAngle1",
    dynlib: odedll.}
proc dJointGetPUAngle1Rate*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetPUAngle1Rate", dynlib: odedll.}
proc dJointGetPUAngle2*(a1: dJointID): dReal {.cdecl, importc: "dJointGetPUAngle2",
    dynlib: odedll.}
proc dJointGetPUAngle2Rate*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetPUAngle2Rate", dynlib: odedll.}
proc dJointGetPUParam*(a1: dJointID; parameter: cint): dReal {.cdecl,
    importc: "dJointGetPUParam", dynlib: odedll.}
proc dJointGetPistonPosition*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetPistonPosition", dynlib: odedll.}
proc dJointGetPistonPositionRate*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetPistonPositionRate", dynlib: odedll.}
proc dJointGetPistonAngle*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetPistonAngle", dynlib: odedll.}
proc dJointGetPistonAngleRate*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetPistonAngleRate", dynlib: odedll.}
proc dJointGetPistonAnchor*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetPistonAnchor", dynlib: odedll.}
proc dJointGetPistonAnchor2*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetPistonAnchor2", dynlib: odedll.}
proc dJointGetPistonAxis*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetPistonAxis", dynlib: odedll.}
proc dJointGetPistonParam*(a1: dJointID; parameter: cint): dReal {.cdecl,
    importc: "dJointGetPistonParam", dynlib: odedll.}
proc dJointGetAMotorNumAxes*(a1: dJointID): cint {.cdecl,
    importc: "dJointGetAMotorNumAxes", dynlib: odedll.}
proc dJointGetAMotorAxis*(a1: dJointID; anum: cint; result: dVector3) {.cdecl,
    importc: "dJointGetAMotorAxis", dynlib: odedll.}
proc dJointGetAMotorAxisRel*(a1: dJointID; anum: cint): cint {.cdecl,
    importc: "dJointGetAMotorAxisRel", dynlib: odedll.}
proc dJointGetAMotorAngle*(a1: dJointID; anum: cint): dReal {.cdecl,
    importc: "dJointGetAMotorAngle", dynlib: odedll.}
proc dJointGetAMotorAngleRate*(a1: dJointID; anum: cint): dReal {.cdecl,
    importc: "dJointGetAMotorAngleRate", dynlib: odedll.}
proc dJointGetAMotorParam*(a1: dJointID; parameter: cint): dReal {.cdecl,
    importc: "dJointGetAMotorParam", dynlib: odedll.}
proc dJointGetAMotorMode*(a1: dJointID): cint {.cdecl,
    importc: "dJointGetAMotorMode", dynlib: odedll.}
proc dJointGetLMotorNumAxes*(a1: dJointID): cint {.cdecl,
    importc: "dJointGetLMotorNumAxes", dynlib: odedll.}
proc dJointGetLMotorAxis*(a1: dJointID; anum: cint; result: dVector3) {.cdecl,
    importc: "dJointGetLMotorAxis", dynlib: odedll.}
proc dJointGetLMotorParam*(a1: dJointID; parameter: cint): dReal {.cdecl,
    importc: "dJointGetLMotorParam", dynlib: odedll.}
proc dJointGetFixedParam*(a1: dJointID; parameter: cint): dReal {.cdecl,
    importc: "dJointGetFixedParam", dynlib: odedll.}
proc dJointGetTransmissionContactPoint1*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetTransmissionContactPoint1", dynlib: odedll.}
proc dJointGetTransmissionContactPoint2*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetTransmissionContactPoint2", dynlib: odedll.}
proc dJointSetTransmissionAxis1*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetTransmissionAxis1", dynlib: odedll.}
proc dJointGetTransmissionAxis1*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetTransmissionAxis1", dynlib: odedll.}
proc dJointSetTransmissionAxis2*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetTransmissionAxis2", dynlib: odedll.}
proc dJointGetTransmissionAxis2*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetTransmissionAxis2", dynlib: odedll.}
proc dJointSetTransmissionAnchor1*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetTransmissionAnchor1", dynlib: odedll.}
proc dJointGetTransmissionAnchor1*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetTransmissionAnchor1", dynlib: odedll.}
proc dJointSetTransmissionAnchor2*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetTransmissionAnchor2", dynlib: odedll.}
proc dJointGetTransmissionAnchor2*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetTransmissionAnchor2", dynlib: odedll.}
proc dJointSetTransmissionParam*(a1: dJointID; parameter: cint; value: dReal) {.cdecl,
    importc: "dJointSetTransmissionParam", dynlib: odedll.}
proc dJointGetTransmissionParam*(a1: dJointID; parameter: cint): dReal {.cdecl,
    importc: "dJointGetTransmissionParam", dynlib: odedll.}
proc dJointSetTransmissionMode*(j: dJointID; mode: cint) {.cdecl,
    importc: "dJointSetTransmissionMode", dynlib: odedll.}
proc dJointGetTransmissionMode*(j: dJointID): cint {.cdecl,
    importc: "dJointGetTransmissionMode", dynlib: odedll.}
proc dJointSetTransmissionRatio*(j: dJointID; ratio: dReal) {.cdecl,
    importc: "dJointSetTransmissionRatio", dynlib: odedll.}
proc dJointGetTransmissionRatio*(j: dJointID): dReal {.cdecl,
    importc: "dJointGetTransmissionRatio", dynlib: odedll.}
proc dJointSetTransmissionAxis*(j: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetTransmissionAxis", dynlib: odedll.}
proc dJointGetTransmissionAxis*(j: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetTransmissionAxis", dynlib: odedll.}
proc dJointGetTransmissionAngle1*(j: dJointID): dReal {.cdecl,
    importc: "dJointGetTransmissionAngle1", dynlib: odedll.}
proc dJointGetTransmissionAngle2*(j: dJointID): dReal {.cdecl,
    importc: "dJointGetTransmissionAngle2", dynlib: odedll.}
proc dJointGetTransmissionRadius1*(j: dJointID): dReal {.cdecl,
    importc: "dJointGetTransmissionRadius1", dynlib: odedll.}
proc dJointGetTransmissionRadius2*(j: dJointID): dReal {.cdecl,
    importc: "dJointGetTransmissionRadius2", dynlib: odedll.}
proc dJointSetTransmissionRadius1*(j: dJointID; radius: dReal) {.cdecl,
    importc: "dJointSetTransmissionRadius1", dynlib: odedll.}
proc dJointSetTransmissionRadius2*(j: dJointID; radius: dReal) {.cdecl,
    importc: "dJointSetTransmissionRadius2", dynlib: odedll.}
proc dJointGetTransmissionBacklash*(j: dJointID): dReal {.cdecl,
    importc: "dJointGetTransmissionBacklash", dynlib: odedll.}
proc dJointSetTransmissionBacklash*(j: dJointID; backlash: dReal) {.cdecl,
    importc: "dJointSetTransmissionBacklash", dynlib: odedll.}
proc dJointSetDBallAnchor1*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetDBallAnchor1", dynlib: odedll.}
proc dJointSetDBallAnchor2*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetDBallAnchor2", dynlib: odedll.}
proc dJointGetDBallAnchor1*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetDBallAnchor1", dynlib: odedll.}
proc dJointGetDBallAnchor2*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetDBallAnchor2", dynlib: odedll.}
proc dJointGetDBallDistance*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetDBallDistance", dynlib: odedll.}
proc dJointSetDBallDistance*(a1: dJointID; dist: dReal) {.cdecl,
    importc: "dJointSetDBallDistance", dynlib: odedll.}
proc dJointSetDBallParam*(a1: dJointID; parameter: cint; value: dReal) {.cdecl,
    importc: "dJointSetDBallParam", dynlib: odedll.}
proc dJointGetDBallParam*(a1: dJointID; parameter: cint): dReal {.cdecl,
    importc: "dJointGetDBallParam", dynlib: odedll.}
proc dJointSetDHingeAxis*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetDHingeAxis", dynlib: odedll.}
proc dJointGetDHingeAxis*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetDHingeAxis", dynlib: odedll.}
proc dJointSetDHingeAnchor1*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetDHingeAnchor1", dynlib: odedll.}
proc dJointSetDHingeAnchor2*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dJointSetDHingeAnchor2", dynlib: odedll.}
proc dJointGetDHingeAnchor1*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetDHingeAnchor1", dynlib: odedll.}
proc dJointGetDHingeAnchor2*(a1: dJointID; result: dVector3) {.cdecl,
    importc: "dJointGetDHingeAnchor2", dynlib: odedll.}
proc dJointGetDHingeDistance*(a1: dJointID): dReal {.cdecl,
    importc: "dJointGetDHingeDistance", dynlib: odedll.}
proc dJointSetDHingeParam*(a1: dJointID; parameter: cint; value: dReal) {.cdecl,
    importc: "dJointSetDHingeParam", dynlib: odedll.}
proc dJointGetDHingeParam*(a1: dJointID; parameter: cint): dReal {.cdecl,
    importc: "dJointGetDHingeParam", dynlib: odedll.}
proc dConnectingJoint*(a1: dBodyID; a2: dBodyID): dJointID {.cdecl,
    importc: "dConnectingJoint", dynlib: odedll.}
proc dConnectingJointList*(a1: dBodyID; a2: dBodyID; a3: ptr dJointID): cint {.cdecl,
    importc: "dConnectingJointList", dynlib: odedll.}
proc dAreConnected*(a1: dBodyID; a2: dBodyID): cint {.cdecl, importc: "dAreConnected",
    dynlib: odedll.}
proc dAreConnectedExcluding*(body1: dBodyID; body2: dBodyID; joint_type: cint): cint {.
    cdecl, importc: "dAreConnectedExcluding", dynlib: odedll.}
proc dSimpleSpaceCreate*(space: dSpaceID): dSpaceID {.cdecl,
    importc: "dSimpleSpaceCreate", dynlib: odedll.}
proc dHashSpaceCreate*(space: dSpaceID): dSpaceID {.cdecl,
    importc: "dHashSpaceCreate", dynlib: odedll.}
proc dQuadTreeSpaceCreate*(space: dSpaceID; Center: dVector3; Extents: dVector3;
                          Depth: cint): dSpaceID {.cdecl,
    importc: "dQuadTreeSpaceCreate", dynlib: odedll.}
proc dSweepAndPruneSpaceCreate*(space: dSpaceID; axisorder: cint): dSpaceID {.cdecl,
    importc: "dSweepAndPruneSpaceCreate", dynlib: odedll.}
proc dSpaceDestroy*(a1: dSpaceID) {.cdecl, importc: "dSpaceDestroy", dynlib: odedll.}
proc dHashSpaceSetLevels*(space: dSpaceID; minlevel: cint; maxlevel: cint) {.cdecl,
    importc: "dHashSpaceSetLevels", dynlib: odedll.}
proc dHashSpaceGetLevels*(space: dSpaceID; minlevel: ptr cint; maxlevel: ptr cint) {.
    cdecl, importc: "dHashSpaceGetLevels", dynlib: odedll.}
proc dSpaceSetCleanup*(space: dSpaceID; mode: cint) {.cdecl,
    importc: "dSpaceSetCleanup", dynlib: odedll.}
proc dSpaceGetCleanup*(space: dSpaceID): cint {.cdecl, importc: "dSpaceGetCleanup",
    dynlib: odedll.}
proc dSpaceSetSublevel*(space: dSpaceID; sublevel: cint) {.cdecl,
    importc: "dSpaceSetSublevel", dynlib: odedll.}
proc dSpaceGetSublevel*(space: dSpaceID): cint {.cdecl, importc: "dSpaceGetSublevel",
    dynlib: odedll.}
proc dSpaceSetManualCleanup*(space: dSpaceID; mode: cint) {.cdecl,
    importc: "dSpaceSetManualCleanup", dynlib: odedll.}
proc dSpaceGetManualCleanup*(space: dSpaceID): cint {.cdecl,
    importc: "dSpaceGetManualCleanup", dynlib: odedll.}
proc dSpaceAdd*(a1: dSpaceID; a2: dGeomID) {.cdecl, importc: "dSpaceAdd", dynlib: odedll.}
proc dSpaceRemove*(a1: dSpaceID; a2: dGeomID) {.cdecl, importc: "dSpaceRemove",
    dynlib: odedll.}
proc dSpaceQuery*(a1: dSpaceID; a2: dGeomID): cint {.cdecl, importc: "dSpaceQuery",
    dynlib: odedll.}
proc dSpaceClean*(a1: dSpaceID) {.cdecl, importc: "dSpaceClean", dynlib: odedll.}
proc dSpaceGetNumGeoms*(a1: dSpaceID): cint {.cdecl, importc: "dSpaceGetNumGeoms",
    dynlib: odedll.}
proc dSpaceGetGeom*(a1: dSpaceID; i: cint): dGeomID {.cdecl, importc: "dSpaceGetGeom",
    dynlib: odedll.}
proc dSpaceGetClass*(space: dSpaceID): cint {.cdecl, importc: "dSpaceGetClass",
    dynlib: odedll.}
proc dGeomDestroy*(geom: dGeomID) {.cdecl, importc: "dGeomDestroy", dynlib: odedll.}
proc dGeomSetData*(geom: dGeomID; data: pointer) {.cdecl, importc: "dGeomSetData",
    dynlib: odedll.}
proc dGeomGetData*(geom: dGeomID): pointer {.cdecl, importc: "dGeomGetData",
    dynlib: odedll.}
proc dGeomSetBody*(geom: dGeomID; body: dBodyID) {.cdecl, importc: "dGeomSetBody",
    dynlib: odedll.}
proc dGeomGetBody*(geom: dGeomID): dBodyID {.cdecl, importc: "dGeomGetBody",
    dynlib: odedll.}
proc dGeomSetPosition*(geom: dGeomID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dGeomSetPosition", dynlib: odedll.}
proc dGeomSetRotation*(geom: dGeomID; R: dMatrix3) {.cdecl,
    importc: "dGeomSetRotation", dynlib: odedll.}
proc dGeomSetQuaternion*(geom: dGeomID; Q: dQuaternion) {.cdecl,
    importc: "dGeomSetQuaternion", dynlib: odedll.}
proc dGeomGetPosition*(geom: dGeomID): ptr dReal {.cdecl, importc: "dGeomGetPosition",
    dynlib: odedll.}
proc dGeomCopyPosition*(geom: dGeomID; pos: dVector3) {.cdecl,
    importc: "dGeomCopyPosition", dynlib: odedll.}
proc dGeomGetRotation*(geom: dGeomID): ptr dReal {.cdecl, importc: "dGeomGetRotation",
    dynlib: odedll.}
proc dGeomCopyRotation*(geom: dGeomID; R: dMatrix3) {.cdecl,
    importc: "dGeomCopyRotation", dynlib: odedll.}
proc dGeomGetQuaternion*(geom: dGeomID; result: dQuaternion) {.cdecl,
    importc: "dGeomGetQuaternion", dynlib: odedll.}
proc dGeomGetAABB*(geom: dGeomID; aabb: array[6, dReal]) {.cdecl,
    importc: "dGeomGetAABB", dynlib: odedll.}
proc dGeomIsSpace*(geom: dGeomID): cint {.cdecl, importc: "dGeomIsSpace",
                                      dynlib: odedll.}
proc dGeomGetSpace*(a1: dGeomID): dSpaceID {.cdecl, importc: "dGeomGetSpace",
    dynlib: odedll.}
proc dGeomGetClass*(geom: dGeomID): cint {.cdecl, importc: "dGeomGetClass",
                                       dynlib: odedll.}
proc dGeomSetCategoryBits*(geom: dGeomID; bits: culong) {.cdecl,
    importc: "dGeomSetCategoryBits", dynlib: odedll.}
proc dGeomSetCollideBits*(geom: dGeomID; bits: culong) {.cdecl,
    importc: "dGeomSetCollideBits", dynlib: odedll.}
proc dGeomGetCategoryBits*(a1: dGeomID): culong {.cdecl,
    importc: "dGeomGetCategoryBits", dynlib: odedll.}
proc dGeomGetCollideBits*(a1: dGeomID): culong {.cdecl,
    importc: "dGeomGetCollideBits", dynlib: odedll.}
proc dGeomEnable*(geom: dGeomID) {.cdecl, importc: "dGeomEnable", dynlib: odedll.}
proc dGeomDisable*(geom: dGeomID) {.cdecl, importc: "dGeomDisable", dynlib: odedll.}
proc dGeomIsEnabled*(geom: dGeomID): cint {.cdecl, importc: "dGeomIsEnabled",
                                        dynlib: odedll.}
proc dGeomLowLevelControl*(geom: dGeomID; controlClass: cint; controlCode: cint;
                          dataValue: pointer; dataSize: ptr cint): cint {.cdecl,
    importc: "dGeomLowLevelControl", dynlib: odedll.}
proc dGeomGetRelPointPos*(geom: dGeomID; px: dReal; py: dReal; pz: dReal;
                         result: dVector3) {.cdecl, importc: "dGeomGetRelPointPos",
    dynlib: odedll.}
proc dGeomGetPosRelPoint*(geom: dGeomID; px: dReal; py: dReal; pz: dReal;
                         result: dVector3) {.cdecl, importc: "dGeomGetPosRelPoint",
    dynlib: odedll.}
proc dGeomVectorToWorld*(geom: dGeomID; px: dReal; py: dReal; pz: dReal; result: dVector3) {.
    cdecl, importc: "dGeomVectorToWorld", dynlib: odedll.}
proc dGeomVectorFromWorld*(geom: dGeomID; px: dReal; py: dReal; pz: dReal;
                          result: dVector3) {.cdecl,
    importc: "dGeomVectorFromWorld", dynlib: odedll.}
proc dGeomSetOffsetPosition*(geom: dGeomID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dGeomSetOffsetPosition", dynlib: odedll.}
proc dGeomSetOffsetRotation*(geom: dGeomID; R: dMatrix3) {.cdecl,
    importc: "dGeomSetOffsetRotation", dynlib: odedll.}
proc dGeomSetOffsetQuaternion*(geom: dGeomID; Q: dQuaternion) {.cdecl,
    importc: "dGeomSetOffsetQuaternion", dynlib: odedll.}
proc dGeomSetOffsetWorldPosition*(geom: dGeomID; x: dReal; y: dReal; z: dReal) {.cdecl,
    importc: "dGeomSetOffsetWorldPosition", dynlib: odedll.}
proc dGeomSetOffsetWorldRotation*(geom: dGeomID; R: dMatrix3) {.cdecl,
    importc: "dGeomSetOffsetWorldRotation", dynlib: odedll.}
proc dGeomSetOffsetWorldQuaternion*(geom: dGeomID; a2: dQuaternion) {.cdecl,
    importc: "dGeomSetOffsetWorldQuaternion", dynlib: odedll.}
proc dGeomClearOffset*(geom: dGeomID) {.cdecl, importc: "dGeomClearOffset",
                                     dynlib: odedll.}
proc dGeomIsOffset*(geom: dGeomID): cint {.cdecl, importc: "dGeomIsOffset",
                                       dynlib: odedll.}
proc dGeomGetOffsetPosition*(geom: dGeomID): ptr dReal {.cdecl,
    importc: "dGeomGetOffsetPosition", dynlib: odedll.}
proc dGeomCopyOffsetPosition*(geom: dGeomID; pos: dVector3) {.cdecl,
    importc: "dGeomCopyOffsetPosition", dynlib: odedll.}
proc dGeomGetOffsetRotation*(geom: dGeomID): ptr dReal {.cdecl,
    importc: "dGeomGetOffsetRotation", dynlib: odedll.}
proc dGeomCopyOffsetRotation*(geom: dGeomID; R: dMatrix3) {.cdecl,
    importc: "dGeomCopyOffsetRotation", dynlib: odedll.}
proc dGeomGetOffsetQuaternion*(geom: dGeomID; result: dQuaternion) {.cdecl,
    importc: "dGeomGetOffsetQuaternion", dynlib: odedll.}
proc dCollide*(o1: dGeomID; o2: dGeomID; flags: cint; contact: ptr dContactGeom;
              skip: cint): cint {.cdecl, importc: "dCollide", dynlib: odedll.}
proc dSpaceCollide*(space: dSpaceID; data: pointer; callback: ptr dNearCallback) {.
    cdecl, importc: "dSpaceCollide", dynlib: odedll.}
proc dSpaceCollide2*(space1: dGeomID; space2: dGeomID; data: pointer;
                    callback: ptr dNearCallback) {.cdecl, importc: "dSpaceCollide2",
    dynlib: odedll.}
proc dCreateSphere*(space: dSpaceID; radius: dReal): dGeomID {.cdecl,
    importc: "dCreateSphere", dynlib: odedll.}
proc dGeomSphereSetRadius*(sphere: dGeomID; radius: dReal) {.cdecl,
    importc: "dGeomSphereSetRadius", dynlib: odedll.}
proc dGeomSphereGetRadius*(sphere: dGeomID): dReal {.cdecl,
    importc: "dGeomSphereGetRadius", dynlib: odedll.}
proc dGeomSpherePointDepth*(sphere: dGeomID; x: dReal; y: dReal; z: dReal): dReal {.cdecl,
    importc: "dGeomSpherePointDepth", dynlib: odedll.}
proc dCreateConvex*(space: dSpaceID; planes: ptr dReal; planecount: cuint;
                   points: ptr dReal; pointcount: cuint; polygons: ptr cuint): dGeomID {.
    cdecl, importc: "dCreateConvex", dynlib: odedll.}
proc dGeomSetConvex*(g: dGeomID; planes: ptr dReal; count: cuint; points: ptr dReal;
                    pointcount: cuint; polygons: ptr cuint) {.cdecl,
    importc: "dGeomSetConvex", dynlib: odedll.}
proc dCreateBox*(space: dSpaceID; lx: dReal; ly: dReal; lz: dReal): dGeomID {.cdecl,
    importc: "dCreateBox", dynlib: odedll.}
proc dGeomBoxSetLengths*(box: dGeomID; lx: dReal; ly: dReal; lz: dReal) {.cdecl,
    importc: "dGeomBoxSetLengths", dynlib: odedll.}
proc dGeomBoxGetLengths*(box: dGeomID; result: dVector3) {.cdecl,
    importc: "dGeomBoxGetLengths", dynlib: odedll.}
proc dGeomBoxPointDepth*(box: dGeomID; x: dReal; y: dReal; z: dReal): dReal {.cdecl,
    importc: "dGeomBoxPointDepth", dynlib: odedll.}
proc dCreatePlane*(space: dSpaceID; a: dReal; b: dReal; c: dReal; d: dReal): dGeomID {.
    cdecl, importc: "dCreatePlane", dynlib: odedll.}
proc dGeomPlaneSetParams*(plane: dGeomID; a: dReal; b: dReal; c: dReal; d: dReal) {.cdecl,
    importc: "dGeomPlaneSetParams", dynlib: odedll.}
proc dGeomPlaneGetParams*(plane: dGeomID; result: dVector4) {.cdecl,
    importc: "dGeomPlaneGetParams", dynlib: odedll.}
proc dGeomPlanePointDepth*(plane: dGeomID; x: dReal; y: dReal; z: dReal): dReal {.cdecl,
    importc: "dGeomPlanePointDepth", dynlib: odedll.}
proc dCreateCapsule*(space: dSpaceID; radius: dReal; length: dReal): dGeomID {.cdecl,
    importc: "dCreateCapsule", dynlib: odedll.}
proc dGeomCapsuleSetParams*(ccylinder: dGeomID; radius: dReal; length: dReal) {.cdecl,
    importc: "dGeomCapsuleSetParams", dynlib: odedll.}
proc dGeomCapsuleGetParams*(ccylinder: dGeomID; radius: ptr dReal; length: ptr dReal) {.
    cdecl, importc: "dGeomCapsuleGetParams", dynlib: odedll.}
proc dGeomCapsulePointDepth*(ccylinder: dGeomID; x: dReal; y: dReal; z: dReal): dReal {.
    cdecl, importc: "dGeomCapsulePointDepth", dynlib: odedll.}
proc dCreateCylinder*(space: dSpaceID; radius: dReal; length: dReal): dGeomID {.cdecl,
    importc: "dCreateCylinder", dynlib: odedll.}
proc dGeomCylinderSetParams*(cylinder: dGeomID; radius: dReal; length: dReal) {.cdecl,
    importc: "dGeomCylinderSetParams", dynlib: odedll.}
proc dGeomCylinderGetParams*(cylinder: dGeomID; radius: ptr dReal; length: ptr dReal) {.
    cdecl, importc: "dGeomCylinderGetParams", dynlib: odedll.}
proc dCreateRay*(space: dSpaceID; length: dReal): dGeomID {.cdecl,
    importc: "dCreateRay", dynlib: odedll.}
proc dGeomRaySetLength*(ray: dGeomID; length: dReal) {.cdecl,
    importc: "dGeomRaySetLength", dynlib: odedll.}
proc dGeomRayGetLength*(ray: dGeomID): dReal {.cdecl, importc: "dGeomRayGetLength",
    dynlib: odedll.}
proc dGeomRaySet*(ray: dGeomID; px: dReal; py: dReal; pz: dReal; dx: dReal; dy: dReal;
                 dz: dReal) {.cdecl, importc: "dGeomRaySet", dynlib: odedll.}
proc dGeomRayGet*(ray: dGeomID; start: dVector3; dir: dVector3) {.cdecl,
    importc: "dGeomRayGet", dynlib: odedll.}
proc dGeomRaySetFirstContact*(g: dGeomID; firstContact: cint) {.cdecl,
    importc: "dGeomRaySetFirstContact", dynlib: odedll.}
proc dGeomRayGetFirstContact*(g: dGeomID): cint {.cdecl,
    importc: "dGeomRayGetFirstContact", dynlib: odedll.}
proc dGeomRaySetBackfaceCull*(g: dGeomID; backfaceCull: cint) {.cdecl,
    importc: "dGeomRaySetBackfaceCull", dynlib: odedll.}
proc dGeomRayGetBackfaceCull*(g: dGeomID): cint {.cdecl,
    importc: "dGeomRayGetBackfaceCull", dynlib: odedll.}
proc dGeomRaySetClosestHit*(g: dGeomID; closestHit: cint) {.cdecl,
    importc: "dGeomRaySetClosestHit", dynlib: odedll.}
proc dGeomRayGetClosestHit*(g: dGeomID): cint {.cdecl,
    importc: "dGeomRayGetClosestHit", dynlib: odedll.}
proc dCreateHeightfield*(space: dSpaceID; data: dHeightfieldDataID; bPlaceable: cint): dGeomID {.
    cdecl, importc: "dCreateHeightfield", dynlib: odedll.}
proc dGeomHeightfieldDataCreate*(): dHeightfieldDataID {.cdecl,
    importc: "dGeomHeightfieldDataCreate", dynlib: odedll.}
proc dGeomHeightfieldDataDestroy*(d: dHeightfieldDataID) {.cdecl,
    importc: "dGeomHeightfieldDataDestroy", dynlib: odedll.}
proc dGeomHeightfieldDataBuildCallback*(d: dHeightfieldDataID; pUserData: pointer;
                                       pCallback: ptr dHeightfieldGetHeight;
                                       width: dReal; depth: dReal;
                                       widthSamples: cint; depthSamples: cint;
                                       scale: dReal; offset: dReal;
                                       thickness: dReal; bWrap: cint) {.cdecl,
    importc: "dGeomHeightfieldDataBuildCallback", dynlib: odedll.}
proc dGeomHeightfieldDataBuildByte*(d: dHeightfieldDataID; pHeightData: ptr cuchar;
                                   bCopyHeightData: cint; width: dReal;
                                   depth: dReal; widthSamples: cint;
                                   depthSamples: cint; scale: dReal; offset: dReal;
                                   thickness: dReal; bWrap: cint) {.cdecl,
    importc: "dGeomHeightfieldDataBuildByte", dynlib: odedll.}
proc dGeomHeightfieldDataBuildShort*(d: dHeightfieldDataID;
                                    pHeightData: ptr cshort; bCopyHeightData: cint;
                                    width: dReal; depth: dReal; widthSamples: cint;
                                    depthSamples: cint; scale: dReal; offset: dReal;
                                    thickness: dReal; bWrap: cint) {.cdecl,
    importc: "dGeomHeightfieldDataBuildShort", dynlib: odedll.}
proc dGeomHeightfieldDataBuildSingle*(d: dHeightfieldDataID;
                                     pHeightData: ptr cfloat;
                                     bCopyHeightData: cint; width: dReal;
                                     depth: dReal; widthSamples: cint;
                                     depthSamples: cint; scale: dReal;
                                     offset: dReal; thickness: dReal; bWrap: cint) {.
    cdecl, importc: "dGeomHeightfieldDataBuildSingle", dynlib: odedll.}
proc dGeomHeightfieldDataBuildDouble*(d: dHeightfieldDataID;
                                     pHeightData: ptr cdouble;
                                     bCopyHeightData: cint; width: dReal;
                                     depth: dReal; widthSamples: cint;
                                     depthSamples: cint; scale: dReal;
                                     offset: dReal; thickness: dReal; bWrap: cint) {.
    cdecl, importc: "dGeomHeightfieldDataBuildDouble", dynlib: odedll.}
proc dGeomHeightfieldDataSetBounds*(d: dHeightfieldDataID; minHeight: dReal;
                                   maxHeight: dReal) {.cdecl,
    importc: "dGeomHeightfieldDataSetBounds", dynlib: odedll.}
proc dGeomHeightfieldSetHeightfieldData*(g: dGeomID; d: dHeightfieldDataID) {.cdecl,
    importc: "dGeomHeightfieldSetHeightfieldData", dynlib: odedll.}
proc dGeomHeightfieldGetHeightfieldData*(g: dGeomID): dHeightfieldDataID {.cdecl,
    importc: "dGeomHeightfieldGetHeightfieldData", dynlib: odedll.}
proc dClosestLineSegmentPoints*(a1: dVector3; a2: dVector3; b1: dVector3; b2: dVector3;
                               cp1: dVector3; cp2: dVector3) {.cdecl,
    importc: "dClosestLineSegmentPoints", dynlib: odedll.}
proc dBoxTouchesBox*(p1: dVector3; R1: dMatrix3; side1: dVector3; p2: dVector3;
                    R2: dMatrix3; side2: dVector3): cint {.cdecl,
    importc: "dBoxTouchesBox", dynlib: odedll.}
proc dBoxBox*(p1: dVector3; R1: dMatrix3; side1: dVector3; p2: dVector3; R2: dMatrix3;
             side2: dVector3; normal: dVector3; depth: ptr dReal;
             return_code: ptr cint; flags: cint; contact: ptr dContactGeom; skip: cint): cint {.
    cdecl, importc: "dBoxBox", dynlib: odedll.}
proc dInfiniteAABB*(geom: dGeomID; aabb: array[6, dReal]) {.cdecl,
    importc: "dInfiniteAABB", dynlib: odedll.}
proc dCreateGeomClass*(classptr: ptr dGeomClass): cint {.cdecl,
    importc: "dCreateGeomClass", dynlib: odedll.}
proc dGeomGetClassData*(a1: dGeomID): pointer {.cdecl, importc: "dGeomGetClassData",
    dynlib: odedll.}
proc dCreateGeom*(classnum: cint): dGeomID {.cdecl, importc: "dCreateGeom",
    dynlib: odedll.}
proc dSetColliderOverride*(i: cint; j: cint; fn: ptr dColliderFn) {.cdecl,
    importc: "dSetColliderOverride", dynlib: odedll.}
proc dThreadingAllocateSelfThreadedImplementation*(): dThreadingImplementationID {.
    cdecl, importc: "dThreadingAllocateSelfThreadedImplementation", dynlib: odedll.}
proc dThreadingAllocateMultiThreadedImplementation*(): dThreadingImplementationID {.
    cdecl, importc: "dThreadingAllocateMultiThreadedImplementation", dynlib: odedll.}
proc dThreadingImplementationGetFunctions*(impl: dThreadingImplementationID): ptr dThreadingFunctionsInfo {.
    cdecl, importc: "dThreadingImplementationGetFunctions", dynlib: odedll.}
proc dThreadingImplementationShutdownProcessing*(impl: dThreadingImplementationID) {.
    cdecl, importc: "dThreadingImplementationShutdownProcessing", dynlib: odedll.}
proc dThreadingImplementationCleanupForRestart*(impl: dThreadingImplementationID) {.
    cdecl, importc: "dThreadingImplementationCleanupForRestart", dynlib: odedll.}
proc dThreadingFreeImplementation*(impl: dThreadingImplementationID) {.cdecl,
    importc: "dThreadingFreeImplementation", dynlib: odedll.}
proc dExternalThreadingServeMultiThreadedImplementation*(
    impl: dThreadingImplementationID; readiness_callback: ptr dThreadReadyToServeCallback; ## =NULL
    callback_context: pointer) {.cdecl, importc: "dExternalThreadingServeMultiThreadedImplementation",
                               dynlib: odedll.}
  ## =NULL
proc dThreadingAllocateThreadPool*(thread_count: cuint; stack_size: dsizeint;
                                  ode_data_allocate_flags: cuint; reserved: pointer): dThreadingThreadPoolID {.
    cdecl, importc: "dThreadingAllocateThreadPool", dynlib: odedll.}
  ## =NULL
proc dThreadingThreadPoolServeMultiThreadedImplementation*(
    pool: dThreadingThreadPoolID; impl: dThreadingImplementationID) {.cdecl,
    importc: "dThreadingThreadPoolServeMultiThreadedImplementation",
    dynlib: odedll.}
proc dThreadingThreadPoolWaitIdleState*(pool: dThreadingThreadPoolID) {.cdecl,
    importc: "dThreadingThreadPoolWaitIdleState", dynlib: odedll.}
proc dThreadingFreeThreadPool*(pool: dThreadingThreadPoolID) {.cdecl,
    importc: "dThreadingFreeThreadPool", dynlib: odedll.}
proc dCooperativeCreate*(functionInfo: ptr dThreadingFunctionsInfo; ## =NULL
                        threadingImpl: dThreadingImplementationID): dCooperativeID {.
    cdecl, importc: "dCooperativeCreate", dynlib: odedll.}
  ## =NULL
proc dCooperativeDestroy*(cooperative: dCooperativeID) {.cdecl,
    importc: "dCooperativeDestroy", dynlib: odedll.}
proc dResourceRequirementsCreate*(cooperative: dCooperativeID): dResourceRequirementsID {.
    cdecl, importc: "dResourceRequirementsCreate", dynlib: odedll.}
proc dResourceRequirementsDestroy*(requirements: dResourceRequirementsID) {.cdecl,
    importc: "dResourceRequirementsDestroy", dynlib: odedll.}
proc dResourceRequirementsClone*(requirements: dResourceRequirementsID): dResourceRequirementsID {.
    cdecl, importc: "dResourceRequirementsClone", dynlib: odedll.}
  ## const
proc dResourceRequirementsMergeIn*(summaryRequirements: dResourceRequirementsID;
                                  extraRequirements: dResourceRequirementsID) {.
    cdecl, importc: "dResourceRequirementsMergeIn", dynlib: odedll.}
  ## const
proc dResourceContainerAcquire*(requirements: dResourceRequirementsID): dResourceContainerID {.
    cdecl, importc: "dResourceContainerAcquire", dynlib: odedll.}
  ## const
proc dResourceContainerDestroy*(resources: dResourceContainerID) {.cdecl,
    importc: "dResourceContainerDestroy", dynlib: odedll.}
proc dWorldExportDIF*(w: dWorldID; file: ptr FILE; world_name: cstring) {.cdecl,
    importc: "dWorldExportDIF", dynlib: odedll.}
