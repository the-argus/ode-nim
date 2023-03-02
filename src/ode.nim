
type
  time_t* = clong


type dxWorld {.header: "ode/ode.h".} = object
type
  dWorldID* = ptr dxWorld

type dxSpace {.header: "ode/ode.h".} = object
type
  dSpaceID* = ptr dxSpace

type dxBody {.header: "ode/ode.h".} = object
type
  dBodyID* = ptr dxBody

type dxGeom {.header: "ode/ode.h".} = object
type
  dGeomID* = ptr dxGeom

type dxJoint {.header: "ode/ode.h".} = object
type
  dJointID* = ptr dxJoint

type dxJointGroup {.header: "ode/ode.h".} = object
type
  dJointGroupID* = ptr dxJointGroup

type dxResourceRequirements {.header: "ode/ode.h".} = object
type
  dResourceRequirementsID* = ptr dxResourceRequirements

type dxResourceContainer {.header: "ode/ode.h".} = object
type
  dResourceContainerID* = ptr dxResourceContainer

type dxCallWait {.header: "ode/ode.h".} = object
type
  dCallWaitID* = ptr dxCallWait

type dxCallReleasee {.header: "ode/ode.h".} = object
type
  dCallReleaseeID* = ptr dxCallReleasee

type dxMutexGroup {.header: "ode/ode.h".} = object
type
  dMutexGroupID* = ptr dxMutexGroup

type dxThreadingImplementation {.header: "ode/ode.h".} = object
type
  dThreadingImplementationID* = ptr dxThreadingImplementation

type dxHeightfieldData {.header: "ode/ode.h".} = object
type
  dHeightfieldDataID* = ptr dxHeightfieldData

type dxThreadingThreadPool {.header: "ode/ode.h".} = object
type
  dThreadingThreadPoolID* = ptr dxThreadingThreadPool

type dxCooperative {.header: "ode/ode.h".} = object
type
  dCooperativeID* = ptr dxCooperative


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
  dMessageFunction* = proc (errnum: cint; msg: cstring; ap: va_list): void
  va_list* {.importc: "va_list", header: "<stdarg.h>".} = object
  dAllocFunction* = proc (size: dsizeint): pointer
  dReallocFunction* = proc (`ptr`: pointer; oldsize: dsizeint; newsize: dsizeint): pointer
  dFreeFunction* = proc (`ptr`: pointer; size: dsizeint): void
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
      max_simultaneous_calls_estimate: ddependencycount_t): cint
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

  dJointType* = enum
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

  dNearCallback* = proc (data: pointer; o1: dGeomID; o2: dGeomID): void
  dHeightfieldGetHeight* = proc (p_user_data: pointer; x: cint; z: cint): dReal
  dGetAABBFn* = proc (a1: dGeomID; aabb: array[6, dReal]): void
  dColliderFn* = proc (o1: dGeomID; o2: dGeomID; flags: cint; contact: ptr dContactGeom;
                    skip: cint): cint
  dGetColliderFnFn* = proc (num: cint): ptr dColliderFn
  dGeomDtorFn* = proc (o: dGeomID): void
  dAABBTestFn* = proc (o1: dGeomID; o2: dGeomID; aabb: array[6, dReal]): cint
  dGeomClass* {.bycopy.} = object
    bytes*: cint
    collider*: ptr dGetColliderFnFn
    aabb*: ptr dGetAABBFn
    aabb_test*: ptr dAABBTestFn
    dtor*: ptr dGeomDtorFn

  dThreadReadyToServeCallback* = proc (callback_context: pointer)


proc dGetConfiguration*(): cstring {.importc: "dGetConfiguration".}
proc dCheckConfiguration*(token: cstring): cint {.importc: "dCheckConfiguration".}
proc dInitODE*() {.importc: "dInitODE".}
proc dInitODE2*(uiInitFlags: cuint): cint {.importc: "dInitODE2".}
  ## =0
proc dAllocateODEDataForThread*(uiAllocateFlags: cuint): cint {.
    importc: "dAllocateODEDataForThread".}
proc dCleanupODEAllDataForThread*() {.importc: "dCleanupODEAllDataForThread".}
proc dCloseODE*() {.importc: "dCloseODE".}
proc dSetErrorHandler*(fn: ptr dMessageFunction) {.importc: "dSetErrorHandler".}
proc dSetDebugHandler*(fn: ptr dMessageFunction) {.importc: "dSetDebugHandler".}
proc dSetMessageHandler*(fn: ptr dMessageFunction) {.importc: "dSetMessageHandler".}
proc dGetErrorHandler*(): ptr dMessageFunction {.importc: "dGetErrorHandler".}
proc dGetDebugHandler*(): ptr dMessageFunction {.importc: "dGetDebugHandler".}
proc dGetMessageHandler*(): ptr dMessageFunction {.importc: "dGetMessageHandler".}
proc dError*(num: cint; msg: cstring) {.varargs, importc: "dError".}
proc dDebug*(num: cint; msg: cstring) {.varargs, importc: "dDebug".}
proc dMessage*(num: cint; msg: cstring) {.varargs, importc: "dMessage".}
proc dSetAllocHandler*(fn: ptr dAllocFunction) {.importc: "dSetAllocHandler".}
proc dSetReallocHandler*(fn: ptr dReallocFunction) {.importc: "dSetReallocHandler".}
proc dSetFreeHandler*(fn: ptr dFreeFunction) {.importc: "dSetFreeHandler".}
proc dGetAllocHandler*(): ptr dAllocFunction {.importc: "dGetAllocHandler".}
proc dGetReallocHandler*(): ptr dReallocFunction {.importc: "dGetReallocHandler".}
proc dGetFreeHandler*(): ptr dFreeFunction {.importc: "dGetFreeHandler".}
proc dAlloc*(size: dsizeint): pointer {.importc: "dAlloc".}
proc dRealloc*(`ptr`: pointer; oldsize: dsizeint; newsize: dsizeint): pointer {.
    importc: "dRealloc".}
proc dFree*(`ptr`: pointer; size: dsizeint) {.importc: "dFree".}
proc dSafeNormalize3*(a: dVector3): cint {.importc: "dSafeNormalize3".}
proc dSafeNormalize4*(a: dVector4): cint {.importc: "dSafeNormalize4".}
proc dNormalize3*(a: dVector3) {.importc: "dNormalize3".}

proc dNormalize4*(a: dVector4) {.importc: "dNormalize4".}

proc dPlaneSpace*(n: dVector3; p: dVector3; q: dVector3) {.importc: "dPlaneSpace".}
proc dOrthogonalizeR*(m: dMatrix3): cint {.importc: "dOrthogonalizeR".}
proc dSetZero*(a: ptr dReal; n: cint) {.importc: "dSetZero".}
proc dSetValue*(a: ptr dReal; n: cint; value: dReal) {.importc: "dSetValue".}
proc dDot*(a: ptr dReal; b: ptr dReal; n: cint): dReal {.importc: "dDot".}
proc dMultiply0*(A: ptr dReal; B: ptr dReal; C: ptr dReal; p: cint; q: cint; r: cint) {.
    importc: "dMultiply0".}
proc dMultiply1*(A: ptr dReal; B: ptr dReal; C: ptr dReal; p: cint; q: cint; r: cint) {.
    importc: "dMultiply1".}
proc dMultiply2*(A: ptr dReal; B: ptr dReal; C: ptr dReal; p: cint; q: cint; r: cint) {.
    importc: "dMultiply2".}
proc dFactorCholesky*(A: ptr dReal; n: cint): cint {.importc: "dFactorCholesky".}
proc dSolveCholesky*(L: ptr dReal; b: ptr dReal; n: cint) {.importc: "dSolveCholesky".}
proc dInvertPDMatrix*(A: ptr dReal; Ainv: ptr dReal; n: cint): cint {.
    importc: "dInvertPDMatrix".}
proc dIsPositiveDefinite*(A: ptr dReal; n: cint): cint {.importc: "dIsPositiveDefinite".}
proc dFactorLDLT*(A: ptr dReal; d: ptr dReal; n: cint; nskip: cint) {.
    importc: "dFactorLDLT".}
proc dSolveL1*(L: ptr dReal; b: ptr dReal; n: cint; nskip: cint) {.importc: "dSolveL1".}
proc dSolveL1T*(L: ptr dReal; b: ptr dReal; n: cint; nskip: cint) {.importc: "dSolveL1T".}
proc dScaleVector*(a: ptr dReal; d: ptr dReal; n: cint) {.importc: "dScaleVector".}
proc dSolveLDLT*(L: ptr dReal; d: ptr dReal; b: ptr dReal; n: cint; nskip: cint) {.
    importc: "dSolveLDLT".}
proc dLDLTAddTL*(L: ptr dReal; d: ptr dReal; a: ptr dReal; n: cint; nskip: cint) {.
    importc: "dLDLTAddTL".}
proc dLDLTRemove*(A: ptr ptr dReal; p: ptr cint; L: ptr dReal; d: ptr dReal; n1: cint; n2: cint;
                 r: cint; nskip: cint) {.importc: "dLDLTRemove".}
proc dRemoveRowCol*(A: ptr dReal; n: cint; nskip: cint; r: cint) {.
    importc: "dRemoveRowCol".}
proc dEstimateCooperativelyFactorLDLTResourceRequirements*(
    requirements: dResourceRequirementsID; maximalAllowedThreadCount: cuint;
    maximalRowCount: cuint) {.importc: "dEstimateCooperativelyFactorLDLTResourceRequirements".}
proc dCooperativelyFactorLDLT*(resources: dResourceContainerID;
                              allowedThreadCount: cuint; A: ptr dReal; d: ptr dReal;
                              rowCount: cuint; rowSkip: cuint) {.
    importc: "dCooperativelyFactorLDLT".}
proc dEstimateCooperativelySolveLDLTResourceRequirements*(
    requirements: dResourceRequirementsID; maximalAllowedThreadCount: cuint;
    maximalRowCount: cuint) {.importc: "dEstimateCooperativelySolveLDLTResourceRequirements".}
proc dCooperativelySolveLDLT*(resources: dResourceContainerID;
                             allowedThreadCount: cuint; L: ptr dReal; d: ptr dReal;
                             b: ptr dReal; rowCount: cuint; rowSkip: cuint) {.
    importc: "dCooperativelySolveLDLT".}
proc dEstimateCooperativelySolveL1StraightResourceRequirements*(
    requirements: dResourceRequirementsID; maximalAllowedThreadCount: cuint;
    maximalRowCount: cuint) {.importc: "dEstimateCooperativelySolveL1StraightResourceRequirements".}
proc dCooperativelySolveL1Straight*(resources: dResourceContainerID;
                                   allowedThreadCount: cuint; L: ptr dReal;
                                   b: ptr dReal; rowCount: cuint; rowSkip: cuint) {.
    importc: "dCooperativelySolveL1Straight".}
proc dEstimateCooperativelySolveL1TransposedResourceRequirements*(
    requirements: dResourceRequirementsID; maximalAllowedThreadCount: cuint;
    maximalRowCount: cuint) {.importc: "dEstimateCooperativelySolveL1TransposedResourceRequirements".}
proc dCooperativelySolveL1Transposed*(resources: dResourceContainerID;
                                     allowedThreadCount: cuint; L: ptr dReal;
                                     b: ptr dReal; rowCount: cuint; rowSkip: cuint) {.
    importc: "dCooperativelySolveL1Transposed".}
proc dEstimateCooperativelyScaleVectorResourceRequirements*(
    requirements: dResourceRequirementsID; maximalAllowedThreadCount: cuint;
    maximalElementCount: cuint) {.importc: "dEstimateCooperativelyScaleVectorResourceRequirements".}
proc dCooperativelyScaleVector*(resources: dResourceContainerID;
                               allowedThreadCount: cuint; dataVector: ptr dReal;
                               scaleVector: ptr dReal; elementCount: cuint) {.
    importc: "dCooperativelyScaleVector".}
proc dStopwatchReset*(a1: ptr dStopwatch) {.importc: "dStopwatchReset".}
proc dStopwatchStart*(a1: ptr dStopwatch) {.importc: "dStopwatchStart".}
proc dStopwatchStop*(a1: ptr dStopwatch) {.importc: "dStopwatchStop".}
proc dStopwatchTime*(a1: ptr dStopwatch): cdouble {.importc: "dStopwatchTime".}

proc dTimerStart*(description: cstring) {.importc: "dTimerStart".}

proc dTimerNow*(description: cstring) {.importc: "dTimerNow".}

proc dTimerEnd*() {.importc: "dTimerEnd".}
proc dTimerReport*(fout: ptr FILE; average: cint) {.importc: "dTimerReport".}
proc dTimerTicksPerSecond*(): cdouble {.importc: "dTimerTicksPerSecond".}
proc dTimerResolution*(): cdouble {.importc: "dTimerResolution".}
proc dRSetIdentity*(R: dMatrix3) {.importc: "dRSetIdentity".}
proc dRFromAxisAndAngle*(R: dMatrix3; ax: dReal; ay: dReal; az: dReal; angle: dReal) {.
    importc: "dRFromAxisAndAngle".}
proc dRFromEulerAngles*(R: dMatrix3; phi: dReal; theta: dReal; psi: dReal) {.
    importc: "dRFromEulerAngles".}
proc dRFrom2Axes*(R: dMatrix3; ax: dReal; ay: dReal; az: dReal; bx: dReal; by: dReal;
                 bz: dReal) {.importc: "dRFrom2Axes".}
proc dRFromZAxis*(R: dMatrix3; ax: dReal; ay: dReal; az: dReal) {.importc: "dRFromZAxis".}
proc dQSetIdentity*(q: dQuaternion) {.importc: "dQSetIdentity".}
proc dQFromAxisAndAngle*(q: dQuaternion; ax: dReal; ay: dReal; az: dReal; angle: dReal) {.
    importc: "dQFromAxisAndAngle".}
proc dQMultiply0*(qa: dQuaternion; qb: dQuaternion; qc: dQuaternion) {.
    importc: "dQMultiply0".}
proc dQMultiply1*(qa: dQuaternion; qb: dQuaternion; qc: dQuaternion) {.
    importc: "dQMultiply1".}
proc dQMultiply2*(qa: dQuaternion; qb: dQuaternion; qc: dQuaternion) {.
    importc: "dQMultiply2".}
proc dQMultiply3*(qa: dQuaternion; qb: dQuaternion; qc: dQuaternion) {.
    importc: "dQMultiply3".}
proc dRfromQ*(R: dMatrix3; q: dQuaternion) {.importc: "dRfromQ".}
proc dQfromR*(q: dQuaternion; R: dMatrix3) {.importc: "dQfromR".}
proc dDQfromW*(dq: array[4, dReal]; w: dVector3; q: dQuaternion) {.importc: "dDQfromW".}
proc dMassCheck*(m: ptr dMass): cint {.importc: "dMassCheck".}
proc dMassSetZero*(a1: ptr dMass) {.importc: "dMassSetZero".}
proc dMassSetParameters*(a1: ptr dMass; themass: dReal; cgx: dReal; cgy: dReal;
                        cgz: dReal; I11: dReal; I22: dReal; I33: dReal; I12: dReal;
                        I13: dReal; I23: dReal) {.importc: "dMassSetParameters".}
proc dMassSetSphere*(a1: ptr dMass; density: dReal; radius: dReal) {.
    importc: "dMassSetSphere".}
proc dMassSetSphereTotal*(a1: ptr dMass; total_mass: dReal; radius: dReal) {.
    importc: "dMassSetSphereTotal".}
proc dMassSetCapsule*(a1: ptr dMass; density: dReal; direction: cint; radius: dReal;
                     length: dReal) {.importc: "dMassSetCapsule".}
proc dMassSetCapsuleTotal*(a1: ptr dMass; total_mass: dReal; direction: cint;
                          radius: dReal; length: dReal) {.
    importc: "dMassSetCapsuleTotal".}
proc dMassSetCylinder*(a1: ptr dMass; density: dReal; direction: cint; radius: dReal;
                      length: dReal) {.importc: "dMassSetCylinder".}
proc dMassSetCylinderTotal*(a1: ptr dMass; total_mass: dReal; direction: cint;
                           radius: dReal; length: dReal) {.
    importc: "dMassSetCylinderTotal".}
proc dMassSetBox*(a1: ptr dMass; density: dReal; lx: dReal; ly: dReal; lz: dReal) {.
    importc: "dMassSetBox".}
proc dMassSetBoxTotal*(a1: ptr dMass; total_mass: dReal; lx: dReal; ly: dReal; lz: dReal) {.
    importc: "dMassSetBoxTotal".}
proc dMassSetTrimesh*(a1: ptr dMass; density: dReal; g: dGeomID) {.
    importc: "dMassSetTrimesh".}
proc dMassSetTrimeshTotal*(m: ptr dMass; total_mass: dReal; g: dGeomID) {.
    importc: "dMassSetTrimeshTotal".}
proc dMassAdjust*(a1: ptr dMass; newmass: dReal) {.importc: "dMassAdjust".}
proc dMassTranslate*(a1: ptr dMass; x: dReal; y: dReal; z: dReal) {.
    importc: "dMassTranslate".}
proc dMassRotate*(a1: ptr dMass; R: dMatrix3) {.importc: "dMassRotate".}
proc dMassAdd*(a: ptr dMass; b: ptr dMass) {.importc: "dMassAdd".}
proc dTestRand*(): cint {.importc: "dTestRand".}
proc dRand*(): culong {.importc: "dRand".}
proc dRandGetSeed*(): culong {.importc: "dRandGetSeed".}
proc dRandSetSeed*(s: culong) {.importc: "dRandSetSeed".}
proc dRandInt*(n: cint): cint {.importc: "dRandInt".}
proc dRandReal*(): dReal {.importc: "dRandReal".}
proc dPrintMatrix*(A: ptr dReal; n: cint; m: cint; fmt: cstring; f: ptr FILE) {.
    importc: "dPrintMatrix".}
proc dMakeRandomVector*(A: ptr dReal; n: cint; range: dReal) {.
    importc: "dMakeRandomVector".}
proc dMakeRandomMatrix*(A: ptr dReal; n: cint; m: cint; range: dReal) {.
    importc: "dMakeRandomMatrix".}
proc dClearUpperTriangle*(A: ptr dReal; n: cint) {.importc: "dClearUpperTriangle".}
proc dMaxDifference*(A: ptr dReal; B: ptr dReal; n: cint; m: cint): dReal {.
    importc: "dMaxDifference".}
proc dMaxDifferenceLowerTriangle*(A: ptr dReal; B: ptr dReal; n: cint): dReal {.
    importc: "dMaxDifferenceLowerTriangle".}
proc dWorldCreate*(): dWorldID {.importc: "dWorldCreate".}
proc dWorldDestroy*(world: dWorldID) {.importc: "dWorldDestroy".}
proc dWorldSetData*(world: dWorldID; data: pointer) {.importc: "dWorldSetData".}
proc dWorldGetData*(world: dWorldID): pointer {.importc: "dWorldGetData".}
proc dWorldSetGravity*(a1: dWorldID; x: dReal; y: dReal; z: dReal) {.
    importc: "dWorldSetGravity".}
proc dWorldGetGravity*(a1: dWorldID; gravity: dVector3) {.importc: "dWorldGetGravity".}
proc dWorldSetERP*(a1: dWorldID; erp: dReal) {.importc: "dWorldSetERP".}
proc dWorldGetERP*(a1: dWorldID): dReal {.importc: "dWorldGetERP".}
proc dWorldSetCFM*(a1: dWorldID; cfm: dReal) {.importc: "dWorldSetCFM".}
proc dWorldGetCFM*(a1: dWorldID): dReal {.importc: "dWorldGetCFM".}
proc dWorldSetStepIslandsProcessingMaxThreadCount*(w: dWorldID; count: cuint) {.
    importc: "dWorldSetStepIslandsProcessingMaxThreadCount".}
proc dWorldGetStepIslandsProcessingMaxThreadCount*(w: dWorldID): cuint {.
    importc: "dWorldGetStepIslandsProcessingMaxThreadCount".}
proc dWorldUseSharedWorkingMemory*(w: dWorldID; from_world: dWorldID): cint {.
    importc: "dWorldUseSharedWorkingMemory".}
  ## =NULL
proc dWorldCleanupWorkingMemory*(w: dWorldID) {.
    importc: "dWorldCleanupWorkingMemory".}
proc dWorldSetStepMemoryReservationPolicy*(w: dWorldID; policyinfo: ptr dWorldStepReserveInfo): cint {.
    importc: "dWorldSetStepMemoryReservationPolicy".}
  ## =NULL
proc dWorldSetStepMemoryManager*(w: dWorldID;
                                memfuncs: ptr dWorldStepMemoryFunctionsInfo): cint {.
    importc: "dWorldSetStepMemoryManager".}
proc dWorldSetStepThreadingImplementation*(w: dWorldID;
    functions_info: ptr dThreadingFunctionsInfo;
    threading_impl: dThreadingImplementationID) {.
    importc: "dWorldSetStepThreadingImplementation".}
proc dWorldStep*(w: dWorldID; stepsize: dReal): cint {.importc: "dWorldStep".}
proc dWorldQuickStep*(w: dWorldID; stepsize: dReal): cint {.importc: "dWorldQuickStep".}
proc dWorldImpulseToForce*(a1: dWorldID; stepsize: dReal; ix: dReal; iy: dReal;
                          iz: dReal; force: dVector3) {.
    importc: "dWorldImpulseToForce".}
proc dWorldSetQuickStepNumIterations*(w: dWorldID; num: cint) {.
    importc: "dWorldSetQuickStepNumIterations".}
proc dWorldGetQuickStepNumIterations*(a1: dWorldID): cint {.
    importc: "dWorldGetQuickStepNumIterations".}
proc dWorldSetQuickStepDynamicIterationParameters*(w: dWorldID; ptr_iteration_premature_exit_delta: ptr dReal; ## =NULL
    ptr_max_num_extra_factor: ptr dReal; ## =NULL
    ptr_extra_iteration_requirement_delta: ptr dReal) {.
    importc: "dWorldSetQuickStepDynamicIterationParameters".}
  ## =NULL
proc dWorldGetQuickStepDynamicIterationParameters*(w: dWorldID; out_iteration_premature_exit_delta: ptr dReal; ## =NULL
    out_max_num_extra_factor: ptr dReal; ## =NULL
    out_extra_iteration_requirement_delta: ptr dReal) {.
    importc: "dWorldGetQuickStepDynamicIterationParameters".}
  ## =NULL
proc dWorldAttachQuickStepDynamicIterationStatisticsSink*(w: dWorldID; var_stats: ptr dWorldQuickStepIterationCount_DynamicAdjustmentStatistics): cint {.
    importc: "dWorldAttachQuickStepDynamicIterationStatisticsSink".}
  ## =NULL
proc dWorldSetQuickStepW*(a1: dWorldID; over_relaxation: dReal) {.
    importc: "dWorldSetQuickStepW".}
proc dWorldGetQuickStepW*(a1: dWorldID): dReal {.importc: "dWorldGetQuickStepW".}
proc dWorldSetContactMaxCorrectingVel*(a1: dWorldID; vel: dReal) {.
    importc: "dWorldSetContactMaxCorrectingVel".}
proc dWorldGetContactMaxCorrectingVel*(a1: dWorldID): dReal {.
    importc: "dWorldGetContactMaxCorrectingVel".}
proc dWorldSetContactSurfaceLayer*(a1: dWorldID; depth: dReal) {.
    importc: "dWorldSetContactSurfaceLayer".}
proc dWorldGetContactSurfaceLayer*(a1: dWorldID): dReal {.
    importc: "dWorldGetContactSurfaceLayer".}
proc dWorldGetAutoDisableLinearThreshold*(a1: dWorldID): dReal {.
    importc: "dWorldGetAutoDisableLinearThreshold".}
proc dWorldSetAutoDisableLinearThreshold*(a1: dWorldID;
    linear_average_threshold: dReal) {.importc: "dWorldSetAutoDisableLinearThreshold".}
proc dWorldGetAutoDisableAngularThreshold*(a1: dWorldID): dReal {.
    importc: "dWorldGetAutoDisableAngularThreshold".}
proc dWorldSetAutoDisableAngularThreshold*(a1: dWorldID;
    angular_average_threshold: dReal) {.importc: "dWorldSetAutoDisableAngularThreshold".}
proc dWorldGetAutoDisableAverageSamplesCount*(a1: dWorldID): cint {.
    importc: "dWorldGetAutoDisableAverageSamplesCount".}
proc dWorldSetAutoDisableAverageSamplesCount*(a1: dWorldID;
    average_samples_count: cuint) {.importc: "dWorldSetAutoDisableAverageSamplesCount".}
proc dWorldGetAutoDisableSteps*(a1: dWorldID): cint {.
    importc: "dWorldGetAutoDisableSteps".}
proc dWorldSetAutoDisableSteps*(a1: dWorldID; steps: cint) {.
    importc: "dWorldSetAutoDisableSteps".}
proc dWorldGetAutoDisableTime*(a1: dWorldID): dReal {.
    importc: "dWorldGetAutoDisableTime".}
proc dWorldSetAutoDisableTime*(a1: dWorldID; time: dReal) {.
    importc: "dWorldSetAutoDisableTime".}
proc dWorldGetAutoDisableFlag*(a1: dWorldID): cint {.
    importc: "dWorldGetAutoDisableFlag".}
proc dWorldSetAutoDisableFlag*(a1: dWorldID; do_auto_disable: cint) {.
    importc: "dWorldSetAutoDisableFlag".}
proc dWorldGetLinearDampingThreshold*(w: dWorldID): dReal {.
    importc: "dWorldGetLinearDampingThreshold".}
proc dWorldSetLinearDampingThreshold*(w: dWorldID; threshold: dReal) {.
    importc: "dWorldSetLinearDampingThreshold".}
proc dWorldGetAngularDampingThreshold*(w: dWorldID): dReal {.
    importc: "dWorldGetAngularDampingThreshold".}
proc dWorldSetAngularDampingThreshold*(w: dWorldID; threshold: dReal) {.
    importc: "dWorldSetAngularDampingThreshold".}
proc dWorldGetLinearDamping*(w: dWorldID): dReal {.importc: "dWorldGetLinearDamping".}
proc dWorldSetLinearDamping*(w: dWorldID; scale: dReal) {.
    importc: "dWorldSetLinearDamping".}
proc dWorldGetAngularDamping*(w: dWorldID): dReal {.
    importc: "dWorldGetAngularDamping".}
proc dWorldSetAngularDamping*(w: dWorldID; scale: dReal) {.
    importc: "dWorldSetAngularDamping".}
proc dWorldSetDamping*(w: dWorldID; linear_scale: dReal; angular_scale: dReal) {.
    importc: "dWorldSetDamping".}
proc dWorldGetMaxAngularSpeed*(w: dWorldID): dReal {.
    importc: "dWorldGetMaxAngularSpeed".}
proc dWorldSetMaxAngularSpeed*(w: dWorldID; max_speed: dReal) {.
    importc: "dWorldSetMaxAngularSpeed".}
proc dBodyGetAutoDisableLinearThreshold*(a1: dBodyID): dReal {.
    importc: "dBodyGetAutoDisableLinearThreshold".}
proc dBodySetAutoDisableLinearThreshold*(a1: dBodyID;
                                        linear_average_threshold: dReal) {.
    importc: "dBodySetAutoDisableLinearThreshold".}
proc dBodyGetAutoDisableAngularThreshold*(a1: dBodyID): dReal {.
    importc: "dBodyGetAutoDisableAngularThreshold".}
proc dBodySetAutoDisableAngularThreshold*(a1: dBodyID;
    angular_average_threshold: dReal) {.importc: "dBodySetAutoDisableAngularThreshold".}
proc dBodyGetAutoDisableAverageSamplesCount*(a1: dBodyID): cint {.
    importc: "dBodyGetAutoDisableAverageSamplesCount".}
proc dBodySetAutoDisableAverageSamplesCount*(a1: dBodyID;
    average_samples_count: cuint) {.importc: "dBodySetAutoDisableAverageSamplesCount".}
proc dBodyGetAutoDisableSteps*(a1: dBodyID): cint {.
    importc: "dBodyGetAutoDisableSteps".}
proc dBodySetAutoDisableSteps*(a1: dBodyID; steps: cint) {.
    importc: "dBodySetAutoDisableSteps".}
proc dBodyGetAutoDisableTime*(a1: dBodyID): dReal {.
    importc: "dBodyGetAutoDisableTime".}
proc dBodySetAutoDisableTime*(a1: dBodyID; time: dReal) {.
    importc: "dBodySetAutoDisableTime".}
proc dBodyGetAutoDisableFlag*(a1: dBodyID): cint {.
    importc: "dBodyGetAutoDisableFlag".}
proc dBodySetAutoDisableFlag*(a1: dBodyID; do_auto_disable: cint) {.
    importc: "dBodySetAutoDisableFlag".}
proc dBodySetAutoDisableDefaults*(a1: dBodyID) {.
    importc: "dBodySetAutoDisableDefaults".}
proc dBodyGetWorld*(a1: dBodyID): dWorldID {.importc: "dBodyGetWorld".}
proc dBodyCreate*(a1: dWorldID): dBodyID {.importc: "dBodyCreate".}
proc dBodyDestroy*(a1: dBodyID) {.importc: "dBodyDestroy".}
proc dBodySetData*(a1: dBodyID; data: pointer) {.importc: "dBodySetData".}
proc dBodyGetData*(a1: dBodyID): pointer {.importc: "dBodyGetData".}
proc dBodySetPosition*(a1: dBodyID; x: dReal; y: dReal; z: dReal) {.
    importc: "dBodySetPosition".}
proc dBodySetRotation*(a1: dBodyID; R: dMatrix3) {.importc: "dBodySetRotation".}
proc dBodySetQuaternion*(a1: dBodyID; q: dQuaternion) {.importc: "dBodySetQuaternion".}
proc dBodySetLinearVel*(a1: dBodyID; x: dReal; y: dReal; z: dReal) {.
    importc: "dBodySetLinearVel".}
proc dBodySetAngularVel*(a1: dBodyID; x: dReal; y: dReal; z: dReal) {.
    importc: "dBodySetAngularVel".}
proc dBodyGetPosition*(a1: dBodyID): ptr dReal {.importc: "dBodyGetPosition".}
proc dBodyCopyPosition*(body: dBodyID; pos: dVector3) {.importc: "dBodyCopyPosition".}
proc dBodyGetRotation*(a1: dBodyID): ptr dReal {.importc: "dBodyGetRotation".}
proc dBodyCopyRotation*(a1: dBodyID; R: dMatrix3) {.importc: "dBodyCopyRotation".}
proc dBodyGetQuaternion*(a1: dBodyID): ptr dReal {.importc: "dBodyGetQuaternion".}
proc dBodyCopyQuaternion*(body: dBodyID; quat: dQuaternion) {.
    importc: "dBodyCopyQuaternion".}
proc dBodyGetLinearVel*(a1: dBodyID): ptr dReal {.importc: "dBodyGetLinearVel".}
proc dBodyGetAngularVel*(a1: dBodyID): ptr dReal {.importc: "dBodyGetAngularVel".}
proc dBodySetMass*(a1: dBodyID; mass: ptr dMass) {.importc: "dBodySetMass".}
proc dBodyGetMass*(a1: dBodyID; mass: ptr dMass) {.importc: "dBodyGetMass".}
proc dBodyAddForce*(a1: dBodyID; fx: dReal; fy: dReal; fz: dReal) {.
    importc: "dBodyAddForce".}
proc dBodyAddTorque*(a1: dBodyID; fx: dReal; fy: dReal; fz: dReal) {.
    importc: "dBodyAddTorque".}
proc dBodyAddRelForce*(a1: dBodyID; fx: dReal; fy: dReal; fz: dReal) {.
    importc: "dBodyAddRelForce".}
proc dBodyAddRelTorque*(a1: dBodyID; fx: dReal; fy: dReal; fz: dReal) {.
    importc: "dBodyAddRelTorque".}
proc dBodyAddForceAtPos*(a1: dBodyID; fx: dReal; fy: dReal; fz: dReal; px: dReal;
                        py: dReal; pz: dReal) {.importc: "dBodyAddForceAtPos".}
proc dBodyAddForceAtRelPos*(a1: dBodyID; fx: dReal; fy: dReal; fz: dReal; px: dReal;
                           py: dReal; pz: dReal) {.importc: "dBodyAddForceAtRelPos".}
proc dBodyAddRelForceAtPos*(a1: dBodyID; fx: dReal; fy: dReal; fz: dReal; px: dReal;
                           py: dReal; pz: dReal) {.importc: "dBodyAddRelForceAtPos".}
proc dBodyAddRelForceAtRelPos*(a1: dBodyID; fx: dReal; fy: dReal; fz: dReal; px: dReal;
                              py: dReal; pz: dReal) {.
    importc: "dBodyAddRelForceAtRelPos".}
proc dBodyGetForce*(a1: dBodyID): ptr dReal {.importc: "dBodyGetForce".}
proc dBodyGetTorque*(a1: dBodyID): ptr dReal {.importc: "dBodyGetTorque".}
proc dBodySetForce*(b: dBodyID; x: dReal; y: dReal; z: dReal) {.importc: "dBodySetForce".}
proc dBodySetTorque*(b: dBodyID; x: dReal; y: dReal; z: dReal) {.
    importc: "dBodySetTorque".}
proc dBodyGetRelPointPos*(a1: dBodyID; px: dReal; py: dReal; pz: dReal; result: dVector3) {.
    importc: "dBodyGetRelPointPos".}
proc dBodyGetRelPointVel*(a1: dBodyID; px: dReal; py: dReal; pz: dReal; result: dVector3) {.
    importc: "dBodyGetRelPointVel".}
proc dBodyGetPointVel*(a1: dBodyID; px: dReal; py: dReal; pz: dReal; result: dVector3) {.
    importc: "dBodyGetPointVel".}
proc dBodyGetPosRelPoint*(a1: dBodyID; px: dReal; py: dReal; pz: dReal; result: dVector3) {.
    importc: "dBodyGetPosRelPoint".}
proc dBodyVectorToWorld*(a1: dBodyID; px: dReal; py: dReal; pz: dReal; result: dVector3) {.
    importc: "dBodyVectorToWorld".}
proc dBodyVectorFromWorld*(a1: dBodyID; px: dReal; py: dReal; pz: dReal; result: dVector3) {.
    importc: "dBodyVectorFromWorld".}
proc dBodySetFiniteRotationMode*(a1: dBodyID; mode: cint) {.
    importc: "dBodySetFiniteRotationMode".}
proc dBodySetFiniteRotationAxis*(a1: dBodyID; x: dReal; y: dReal; z: dReal) {.
    importc: "dBodySetFiniteRotationAxis".}
proc dBodyGetFiniteRotationMode*(a1: dBodyID): cint {.
    importc: "dBodyGetFiniteRotationMode".}
proc dBodyGetFiniteRotationAxis*(a1: dBodyID; result: dVector3) {.
    importc: "dBodyGetFiniteRotationAxis".}
proc dBodyGetNumJoints*(b: dBodyID): cint {.importc: "dBodyGetNumJoints".}
proc dBodyGetJoint*(a1: dBodyID; index: cint): dJointID {.importc: "dBodyGetJoint".}
proc dBodySetDynamic*(a1: dBodyID) {.importc: "dBodySetDynamic".}
proc dBodySetKinematic*(a1: dBodyID) {.importc: "dBodySetKinematic".}
proc dBodyIsKinematic*(a1: dBodyID): cint {.importc: "dBodyIsKinematic".}
proc dBodyEnable*(a1: dBodyID) {.importc: "dBodyEnable".}
proc dBodyDisable*(a1: dBodyID) {.importc: "dBodyDisable".}
proc dBodyIsEnabled*(a1: dBodyID): cint {.importc: "dBodyIsEnabled".}
proc dBodySetGravityMode*(b: dBodyID; mode: cint) {.importc: "dBodySetGravityMode".}
proc dBodyGetGravityMode*(b: dBodyID): cint {.importc: "dBodyGetGravityMode".}
proc dBodySetMovedCallback*(b: dBodyID; callback: proc (a1: dBodyID)) {.
    importc: "dBodySetMovedCallback".}
proc dBodyGetFirstGeom*(b: dBodyID): dGeomID {.importc: "dBodyGetFirstGeom".}
proc dBodyGetNextGeom*(g: dGeomID): dGeomID {.importc: "dBodyGetNextGeom".}
proc dBodySetDampingDefaults*(b: dBodyID) {.importc: "dBodySetDampingDefaults".}
proc dBodyGetLinearDamping*(b: dBodyID): dReal {.importc: "dBodyGetLinearDamping".}
proc dBodySetLinearDamping*(b: dBodyID; scale: dReal) {.
    importc: "dBodySetLinearDamping".}
proc dBodyGetAngularDamping*(b: dBodyID): dReal {.importc: "dBodyGetAngularDamping".}
proc dBodySetAngularDamping*(b: dBodyID; scale: dReal) {.
    importc: "dBodySetAngularDamping".}
proc dBodySetDamping*(b: dBodyID; linear_scale: dReal; angular_scale: dReal) {.
    importc: "dBodySetDamping".}
proc dBodyGetLinearDampingThreshold*(b: dBodyID): dReal {.
    importc: "dBodyGetLinearDampingThreshold".}
proc dBodySetLinearDampingThreshold*(b: dBodyID; threshold: dReal) {.
    importc: "dBodySetLinearDampingThreshold".}
proc dBodyGetAngularDampingThreshold*(b: dBodyID): dReal {.
    importc: "dBodyGetAngularDampingThreshold".}
proc dBodySetAngularDampingThreshold*(b: dBodyID; threshold: dReal) {.
    importc: "dBodySetAngularDampingThreshold".}
proc dBodyGetMaxAngularSpeed*(b: dBodyID): dReal {.
    importc: "dBodyGetMaxAngularSpeed".}
proc dBodySetMaxAngularSpeed*(b: dBodyID; max_speed: dReal) {.
    importc: "dBodySetMaxAngularSpeed".}
proc dBodyGetGyroscopicMode*(b: dBodyID): cint {.importc: "dBodyGetGyroscopicMode".}
proc dBodySetGyroscopicMode*(b: dBodyID; enabled: cint) {.
    importc: "dBodySetGyroscopicMode".}
proc dJointCreateBall*(a1: dWorldID; a2: dJointGroupID): dJointID {.
    importc: "dJointCreateBall".}
proc dJointCreateHinge*(a1: dWorldID; a2: dJointGroupID): dJointID {.
    importc: "dJointCreateHinge".}
proc dJointCreateSlider*(a1: dWorldID; a2: dJointGroupID): dJointID {.
    importc: "dJointCreateSlider".}
proc dJointCreateContact*(a1: dWorldID; a2: dJointGroupID; a3: ptr dContact): dJointID {.
    importc: "dJointCreateContact".}
proc dJointCreateHinge2*(a1: dWorldID; a2: dJointGroupID): dJointID {.
    importc: "dJointCreateHinge2".}
proc dJointCreateUniversal*(a1: dWorldID; a2: dJointGroupID): dJointID {.
    importc: "dJointCreateUniversal".}
proc dJointCreatePR*(a1: dWorldID; a2: dJointGroupID): dJointID {.
    importc: "dJointCreatePR".}
proc dJointCreatePU*(a1: dWorldID; a2: dJointGroupID): dJointID {.
    importc: "dJointCreatePU".}
proc dJointCreatePiston*(a1: dWorldID; a2: dJointGroupID): dJointID {.
    importc: "dJointCreatePiston".}
proc dJointCreateFixed*(a1: dWorldID; a2: dJointGroupID): dJointID {.
    importc: "dJointCreateFixed".}
proc dJointCreateNull*(a1: dWorldID; a2: dJointGroupID): dJointID {.
    importc: "dJointCreateNull".}
proc dJointCreateAMotor*(a1: dWorldID; a2: dJointGroupID): dJointID {.
    importc: "dJointCreateAMotor".}
proc dJointCreateLMotor*(a1: dWorldID; a2: dJointGroupID): dJointID {.
    importc: "dJointCreateLMotor".}
proc dJointCreatePlane2D*(a1: dWorldID; a2: dJointGroupID): dJointID {.
    importc: "dJointCreatePlane2D".}
proc dJointCreateDBall*(a1: dWorldID; a2: dJointGroupID): dJointID {.
    importc: "dJointCreateDBall".}
proc dJointCreateDHinge*(a1: dWorldID; a2: dJointGroupID): dJointID {.
    importc: "dJointCreateDHinge".}
proc dJointCreateTransmission*(a1: dWorldID; a2: dJointGroupID): dJointID {.
    importc: "dJointCreateTransmission".}
proc dJointDestroy*(a1: dJointID) {.importc: "dJointDestroy".}
proc dJointGroupCreate*(max_size: cint): dJointGroupID {.
    importc: "dJointGroupCreate".}
proc dJointGroupDestroy*(a1: dJointGroupID) {.importc: "dJointGroupDestroy".}
proc dJointGroupEmpty*(a1: dJointGroupID) {.importc: "dJointGroupEmpty".}
proc dJointGetNumBodies*(a1: dJointID): cint {.importc: "dJointGetNumBodies".}
proc dJointAttach*(a1: dJointID; body1: dBodyID; body2: dBodyID) {.
    importc: "dJointAttach".}
proc dJointEnable*(a1: dJointID) {.importc: "dJointEnable".}
proc dJointDisable*(a1: dJointID) {.importc: "dJointDisable".}
proc dJointIsEnabled*(a1: dJointID): cint {.importc: "dJointIsEnabled".}
proc dJointSetData*(a1: dJointID; data: pointer) {.importc: "dJointSetData".}
proc dJointGetData*(a1: dJointID): pointer {.importc: "dJointGetData".}
proc dJointGetType*(a1: dJointID): dJointType {.importc: "dJointGetType".}
proc dJointGetBody*(a1: dJointID; index: cint): dBodyID {.importc: "dJointGetBody".}
proc dJointSetFeedback*(a1: dJointID; a2: ptr dJointFeedback) {.
    importc: "dJointSetFeedback".}
proc dJointGetFeedback*(a1: dJointID): ptr dJointFeedback {.
    importc: "dJointGetFeedback".}
proc dJointSetBallAnchor*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetBallAnchor".}
proc dJointSetBallAnchor2*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetBallAnchor2".}
proc dJointSetBallParam*(a1: dJointID; parameter: cint; value: dReal) {.
    importc: "dJointSetBallParam".}
proc dJointSetHingeAnchor*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetHingeAnchor".}
proc dJointSetHingeAnchorDelta*(a1: dJointID; x: dReal; y: dReal; z: dReal; ax: dReal;
                               ay: dReal; az: dReal) {.
    importc: "dJointSetHingeAnchorDelta".}
proc dJointSetHingeAxis*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetHingeAxis".}
proc dJointSetHingeAxisOffset*(j: dJointID; x: dReal; y: dReal; z: dReal; angle: dReal) {.
    importc: "dJointSetHingeAxisOffset".}
proc dJointSetHingeParam*(a1: dJointID; parameter: cint; value: dReal) {.
    importc: "dJointSetHingeParam".}
proc dJointAddHingeTorque*(joint: dJointID; torque: dReal) {.
    importc: "dJointAddHingeTorque".}
proc dJointSetSliderAxis*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetSliderAxis".}
proc dJointSetSliderAxisDelta*(a1: dJointID; x: dReal; y: dReal; z: dReal; ax: dReal;
                              ay: dReal; az: dReal) {.
    importc: "dJointSetSliderAxisDelta".}
proc dJointSetSliderParam*(a1: dJointID; parameter: cint; value: dReal) {.
    importc: "dJointSetSliderParam".}
proc dJointAddSliderForce*(joint: dJointID; force: dReal) {.
    importc: "dJointAddSliderForce".}
proc dJointSetHinge2Anchor*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetHinge2Anchor".}
proc dJointSetHinge2Axes*(j: dJointID; axis1: ptr dReal; ## =[dSA__MAX],=NULL
                         axis2: ptr dReal) {.importc: "dJointSetHinge2Axes".}
  ## =[dSA__MAX],=NULL
proc dJointSetHinge2Param*(a1: dJointID; parameter: cint; value: dReal) {.
    importc: "dJointSetHinge2Param".}
proc dJointAddHinge2Torques*(joint: dJointID; torque1: dReal; torque2: dReal) {.
    importc: "dJointAddHinge2Torques".}
proc dJointSetUniversalAnchor*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetUniversalAnchor".}
proc dJointSetUniversalAxis1*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetUniversalAxis1".}
proc dJointSetUniversalAxis1Offset*(a1: dJointID; x: dReal; y: dReal; z: dReal;
                                   offset1: dReal; offset2: dReal) {.
    importc: "dJointSetUniversalAxis1Offset".}
proc dJointSetUniversalAxis2*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetUniversalAxis2".}
proc dJointSetUniversalAxis2Offset*(a1: dJointID; x: dReal; y: dReal; z: dReal;
                                   offset1: dReal; offset2: dReal) {.
    importc: "dJointSetUniversalAxis2Offset".}
proc dJointSetUniversalParam*(a1: dJointID; parameter: cint; value: dReal) {.
    importc: "dJointSetUniversalParam".}
proc dJointAddUniversalTorques*(joint: dJointID; torque1: dReal; torque2: dReal) {.
    importc: "dJointAddUniversalTorques".}
proc dJointSetPRAnchor*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetPRAnchor".}
proc dJointSetPRAxis1*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetPRAxis1".}
proc dJointSetPRAxis2*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetPRAxis2".}
proc dJointSetPRParam*(a1: dJointID; parameter: cint; value: dReal) {.
    importc: "dJointSetPRParam".}
proc dJointAddPRTorque*(j: dJointID; torque: dReal) {.importc: "dJointAddPRTorque".}
proc dJointSetPUAnchor*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetPUAnchor".}
proc dJointSetPUAnchorOffset*(a1: dJointID; x: dReal; y: dReal; z: dReal; dx: dReal;
                             dy: dReal; dz: dReal) {.
    importc: "dJointSetPUAnchorOffset".}
proc dJointSetPUAxis1*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetPUAxis1".}
proc dJointSetPUAxis2*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetPUAxis2".}
proc dJointSetPUAxis3*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetPUAxis3".}
proc dJointSetPUAxisP*(id: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetPUAxisP".}
proc dJointSetPUParam*(a1: dJointID; parameter: cint; value: dReal) {.
    importc: "dJointSetPUParam".}
proc dJointAddPUTorque*(j: dJointID; torque: dReal) {.importc: "dJointAddPUTorque".}
proc dJointSetPistonAnchor*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetPistonAnchor".}
proc dJointSetPistonAnchorOffset*(j: dJointID; x: dReal; y: dReal; z: dReal; dx: dReal;
                                 dy: dReal; dz: dReal) {.
    importc: "dJointSetPistonAnchorOffset".}
proc dJointSetPistonAxis*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetPistonAxis".}
proc dJointSetPistonParam*(a1: dJointID; parameter: cint; value: dReal) {.
    importc: "dJointSetPistonParam".}
proc dJointAddPistonForce*(joint: dJointID; force: dReal) {.
    importc: "dJointAddPistonForce".}
proc dJointSetFixed*(a1: dJointID) {.importc: "dJointSetFixed".}
proc dJointSetFixedParam*(a1: dJointID; parameter: cint; value: dReal) {.
    importc: "dJointSetFixedParam".}
proc dJointSetAMotorNumAxes*(a1: dJointID; num: cint) {.
    importc: "dJointSetAMotorNumAxes".}
proc dJointSetAMotorAxis*(a1: dJointID; anum: cint; rel: cint; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetAMotorAxis".}
proc dJointSetAMotorAngle*(a1: dJointID; anum: cint; angle: dReal) {.
    importc: "dJointSetAMotorAngle".}
proc dJointSetAMotorParam*(a1: dJointID; parameter: cint; value: dReal) {.
    importc: "dJointSetAMotorParam".}
proc dJointSetAMotorMode*(a1: dJointID; mode: cint) {.importc: "dJointSetAMotorMode".}
proc dJointAddAMotorTorques*(a1: dJointID; torque1: dReal; torque2: dReal;
                            torque3: dReal) {.importc: "dJointAddAMotorTorques".}
proc dJointSetLMotorNumAxes*(a1: dJointID; num: cint) {.
    importc: "dJointSetLMotorNumAxes".}
proc dJointSetLMotorAxis*(a1: dJointID; anum: cint; rel: cint; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetLMotorAxis".}
proc dJointSetLMotorParam*(a1: dJointID; parameter: cint; value: dReal) {.
    importc: "dJointSetLMotorParam".}
proc dJointSetPlane2DXParam*(a1: dJointID; parameter: cint; value: dReal) {.
    importc: "dJointSetPlane2DXParam".}
proc dJointSetPlane2DYParam*(a1: dJointID; parameter: cint; value: dReal) {.
    importc: "dJointSetPlane2DYParam".}
proc dJointSetPlane2DAngleParam*(a1: dJointID; parameter: cint; value: dReal) {.
    importc: "dJointSetPlane2DAngleParam".}
proc dJointGetBallAnchor*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetBallAnchor".}
proc dJointGetBallAnchor2*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetBallAnchor2".}
proc dJointGetBallParam*(a1: dJointID; parameter: cint): dReal {.
    importc: "dJointGetBallParam".}
proc dJointGetHingeAnchor*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetHingeAnchor".}
proc dJointGetHingeAnchor2*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetHingeAnchor2".}
proc dJointGetHingeAxis*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetHingeAxis".}
proc dJointGetHingeParam*(a1: dJointID; parameter: cint): dReal {.
    importc: "dJointGetHingeParam".}
proc dJointGetHingeAngle*(a1: dJointID): dReal {.importc: "dJointGetHingeAngle".}
proc dJointGetHingeAngleRate*(a1: dJointID): dReal {.
    importc: "dJointGetHingeAngleRate".}
proc dJointGetSliderPosition*(a1: dJointID): dReal {.
    importc: "dJointGetSliderPosition".}
proc dJointGetSliderPositionRate*(a1: dJointID): dReal {.
    importc: "dJointGetSliderPositionRate".}
proc dJointGetSliderAxis*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetSliderAxis".}
proc dJointGetSliderParam*(a1: dJointID; parameter: cint): dReal {.
    importc: "dJointGetSliderParam".}
proc dJointGetHinge2Anchor*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetHinge2Anchor".}
proc dJointGetHinge2Anchor2*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetHinge2Anchor2".}
proc dJointGetHinge2Axis1*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetHinge2Axis1".}
proc dJointGetHinge2Axis2*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetHinge2Axis2".}
proc dJointGetHinge2Param*(a1: dJointID; parameter: cint): dReal {.
    importc: "dJointGetHinge2Param".}
proc dJointGetHinge2Angle1*(a1: dJointID): dReal {.importc: "dJointGetHinge2Angle1".}
proc dJointGetHinge2Angle2*(a1: dJointID): dReal {.importc: "dJointGetHinge2Angle2".}
proc dJointGetHinge2Angle1Rate*(a1: dJointID): dReal {.
    importc: "dJointGetHinge2Angle1Rate".}
proc dJointGetHinge2Angle2Rate*(a1: dJointID): dReal {.
    importc: "dJointGetHinge2Angle2Rate".}
proc dJointGetUniversalAnchor*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetUniversalAnchor".}
proc dJointGetUniversalAnchor2*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetUniversalAnchor2".}
proc dJointGetUniversalAxis1*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetUniversalAxis1".}
proc dJointGetUniversalAxis2*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetUniversalAxis2".}
proc dJointGetUniversalParam*(a1: dJointID; parameter: cint): dReal {.
    importc: "dJointGetUniversalParam".}
proc dJointGetUniversalAngles*(a1: dJointID; angle1: ptr dReal; angle2: ptr dReal) {.
    importc: "dJointGetUniversalAngles".}
proc dJointGetUniversalAngle1*(a1: dJointID): dReal {.
    importc: "dJointGetUniversalAngle1".}
proc dJointGetUniversalAngle2*(a1: dJointID): dReal {.
    importc: "dJointGetUniversalAngle2".}
proc dJointGetUniversalAngle1Rate*(a1: dJointID): dReal {.
    importc: "dJointGetUniversalAngle1Rate".}
proc dJointGetUniversalAngle2Rate*(a1: dJointID): dReal {.
    importc: "dJointGetUniversalAngle2Rate".}
proc dJointGetPRAnchor*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetPRAnchor".}
proc dJointGetPRPosition*(a1: dJointID): dReal {.importc: "dJointGetPRPosition".}
proc dJointGetPRPositionRate*(a1: dJointID): dReal {.
    importc: "dJointGetPRPositionRate".}
proc dJointGetPRAngle*(a1: dJointID): dReal {.importc: "dJointGetPRAngle".}
proc dJointGetPRAngleRate*(a1: dJointID): dReal {.importc: "dJointGetPRAngleRate".}
proc dJointGetPRAxis1*(a1: dJointID; result: dVector3) {.importc: "dJointGetPRAxis1".}
proc dJointGetPRAxis2*(a1: dJointID; result: dVector3) {.importc: "dJointGetPRAxis2".}
proc dJointGetPRParam*(a1: dJointID; parameter: cint): dReal {.
    importc: "dJointGetPRParam".}
proc dJointGetPUAnchor*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetPUAnchor".}
proc dJointGetPUPosition*(a1: dJointID): dReal {.importc: "dJointGetPUPosition".}
proc dJointGetPUPositionRate*(a1: dJointID): dReal {.
    importc: "dJointGetPUPositionRate".}
proc dJointGetPUAxis1*(a1: dJointID; result: dVector3) {.importc: "dJointGetPUAxis1".}
proc dJointGetPUAxis2*(a1: dJointID; result: dVector3) {.importc: "dJointGetPUAxis2".}
proc dJointGetPUAxis3*(a1: dJointID; result: dVector3) {.importc: "dJointGetPUAxis3".}
proc dJointGetPUAxisP*(id: dJointID; result: dVector3) {.importc: "dJointGetPUAxisP".}
proc dJointGetPUAngles*(a1: dJointID; angle1: ptr dReal; angle2: ptr dReal) {.
    importc: "dJointGetPUAngles".}
proc dJointGetPUAngle1*(a1: dJointID): dReal {.importc: "dJointGetPUAngle1".}
proc dJointGetPUAngle1Rate*(a1: dJointID): dReal {.importc: "dJointGetPUAngle1Rate".}
proc dJointGetPUAngle2*(a1: dJointID): dReal {.importc: "dJointGetPUAngle2".}
proc dJointGetPUAngle2Rate*(a1: dJointID): dReal {.importc: "dJointGetPUAngle2Rate".}
proc dJointGetPUParam*(a1: dJointID; parameter: cint): dReal {.
    importc: "dJointGetPUParam".}
proc dJointGetPistonPosition*(a1: dJointID): dReal {.
    importc: "dJointGetPistonPosition".}
proc dJointGetPistonPositionRate*(a1: dJointID): dReal {.
    importc: "dJointGetPistonPositionRate".}
proc dJointGetPistonAngle*(a1: dJointID): dReal {.importc: "dJointGetPistonAngle".}
proc dJointGetPistonAngleRate*(a1: dJointID): dReal {.
    importc: "dJointGetPistonAngleRate".}
proc dJointGetPistonAnchor*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetPistonAnchor".}
proc dJointGetPistonAnchor2*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetPistonAnchor2".}
proc dJointGetPistonAxis*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetPistonAxis".}
proc dJointGetPistonParam*(a1: dJointID; parameter: cint): dReal {.
    importc: "dJointGetPistonParam".}
proc dJointGetAMotorNumAxes*(a1: dJointID): cint {.importc: "dJointGetAMotorNumAxes".}
proc dJointGetAMotorAxis*(a1: dJointID; anum: cint; result: dVector3) {.
    importc: "dJointGetAMotorAxis".}
proc dJointGetAMotorAxisRel*(a1: dJointID; anum: cint): cint {.
    importc: "dJointGetAMotorAxisRel".}
proc dJointGetAMotorAngle*(a1: dJointID; anum: cint): dReal {.
    importc: "dJointGetAMotorAngle".}
proc dJointGetAMotorAngleRate*(a1: dJointID; anum: cint): dReal {.
    importc: "dJointGetAMotorAngleRate".}
proc dJointGetAMotorParam*(a1: dJointID; parameter: cint): dReal {.
    importc: "dJointGetAMotorParam".}
proc dJointGetAMotorMode*(a1: dJointID): cint {.importc: "dJointGetAMotorMode".}
proc dJointGetLMotorNumAxes*(a1: dJointID): cint {.importc: "dJointGetLMotorNumAxes".}
proc dJointGetLMotorAxis*(a1: dJointID; anum: cint; result: dVector3) {.
    importc: "dJointGetLMotorAxis".}
proc dJointGetLMotorParam*(a1: dJointID; parameter: cint): dReal {.
    importc: "dJointGetLMotorParam".}
proc dJointGetFixedParam*(a1: dJointID; parameter: cint): dReal {.
    importc: "dJointGetFixedParam".}
proc dJointGetTransmissionContactPoint1*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetTransmissionContactPoint1".}
proc dJointGetTransmissionContactPoint2*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetTransmissionContactPoint2".}
proc dJointSetTransmissionAxis1*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetTransmissionAxis1".}
proc dJointGetTransmissionAxis1*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetTransmissionAxis1".}
proc dJointSetTransmissionAxis2*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetTransmissionAxis2".}
proc dJointGetTransmissionAxis2*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetTransmissionAxis2".}
proc dJointSetTransmissionAnchor1*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetTransmissionAnchor1".}
proc dJointGetTransmissionAnchor1*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetTransmissionAnchor1".}
proc dJointSetTransmissionAnchor2*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetTransmissionAnchor2".}
proc dJointGetTransmissionAnchor2*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetTransmissionAnchor2".}
proc dJointSetTransmissionParam*(a1: dJointID; parameter: cint; value: dReal) {.
    importc: "dJointSetTransmissionParam".}
proc dJointGetTransmissionParam*(a1: dJointID; parameter: cint): dReal {.
    importc: "dJointGetTransmissionParam".}
proc dJointSetTransmissionMode*(j: dJointID; mode: cint) {.
    importc: "dJointSetTransmissionMode".}
proc dJointGetTransmissionMode*(j: dJointID): cint {.
    importc: "dJointGetTransmissionMode".}
proc dJointSetTransmissionRatio*(j: dJointID; ratio: dReal) {.
    importc: "dJointSetTransmissionRatio".}
proc dJointGetTransmissionRatio*(j: dJointID): dReal {.
    importc: "dJointGetTransmissionRatio".}
proc dJointSetTransmissionAxis*(j: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetTransmissionAxis".}
proc dJointGetTransmissionAxis*(j: dJointID; result: dVector3) {.
    importc: "dJointGetTransmissionAxis".}
proc dJointGetTransmissionAngle1*(j: dJointID): dReal {.
    importc: "dJointGetTransmissionAngle1".}
proc dJointGetTransmissionAngle2*(j: dJointID): dReal {.
    importc: "dJointGetTransmissionAngle2".}
proc dJointGetTransmissionRadius1*(j: dJointID): dReal {.
    importc: "dJointGetTransmissionRadius1".}
proc dJointGetTransmissionRadius2*(j: dJointID): dReal {.
    importc: "dJointGetTransmissionRadius2".}
proc dJointSetTransmissionRadius1*(j: dJointID; radius: dReal) {.
    importc: "dJointSetTransmissionRadius1".}
proc dJointSetTransmissionRadius2*(j: dJointID; radius: dReal) {.
    importc: "dJointSetTransmissionRadius2".}
proc dJointGetTransmissionBacklash*(j: dJointID): dReal {.
    importc: "dJointGetTransmissionBacklash".}
proc dJointSetTransmissionBacklash*(j: dJointID; backlash: dReal) {.
    importc: "dJointSetTransmissionBacklash".}
proc dJointSetDBallAnchor1*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetDBallAnchor1".}
proc dJointSetDBallAnchor2*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetDBallAnchor2".}
proc dJointGetDBallAnchor1*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetDBallAnchor1".}
proc dJointGetDBallAnchor2*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetDBallAnchor2".}
proc dJointGetDBallDistance*(a1: dJointID): dReal {.
    importc: "dJointGetDBallDistance".}
proc dJointSetDBallDistance*(a1: dJointID; dist: dReal) {.
    importc: "dJointSetDBallDistance".}
proc dJointSetDBallParam*(a1: dJointID; parameter: cint; value: dReal) {.
    importc: "dJointSetDBallParam".}
proc dJointGetDBallParam*(a1: dJointID; parameter: cint): dReal {.
    importc: "dJointGetDBallParam".}
proc dJointSetDHingeAxis*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetDHingeAxis".}
proc dJointGetDHingeAxis*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetDHingeAxis".}
proc dJointSetDHingeAnchor1*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetDHingeAnchor1".}
proc dJointSetDHingeAnchor2*(a1: dJointID; x: dReal; y: dReal; z: dReal) {.
    importc: "dJointSetDHingeAnchor2".}
proc dJointGetDHingeAnchor1*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetDHingeAnchor1".}
proc dJointGetDHingeAnchor2*(a1: dJointID; result: dVector3) {.
    importc: "dJointGetDHingeAnchor2".}
proc dJointGetDHingeDistance*(a1: dJointID): dReal {.
    importc: "dJointGetDHingeDistance".}
proc dJointSetDHingeParam*(a1: dJointID; parameter: cint; value: dReal) {.
    importc: "dJointSetDHingeParam".}
proc dJointGetDHingeParam*(a1: dJointID; parameter: cint): dReal {.
    importc: "dJointGetDHingeParam".}
proc dConnectingJoint*(a1: dBodyID; a2: dBodyID): dJointID {.
    importc: "dConnectingJoint".}
proc dConnectingJointList*(a1: dBodyID; a2: dBodyID; a3: ptr dJointID): cint {.
    importc: "dConnectingJointList".}
proc dAreConnected*(a1: dBodyID; a2: dBodyID): cint {.importc: "dAreConnected".}
proc dAreConnectedExcluding*(body1: dBodyID; body2: dBodyID; joint_type: cint): cint {.
    importc: "dAreConnectedExcluding".}
proc dSimpleSpaceCreate*(space: dSpaceID): dSpaceID {.importc: "dSimpleSpaceCreate".}
proc dHashSpaceCreate*(space: dSpaceID): dSpaceID {.importc: "dHashSpaceCreate".}
proc dQuadTreeSpaceCreate*(space: dSpaceID; Center: dVector3; Extents: dVector3;
                          Depth: cint): dSpaceID {.importc: "dQuadTreeSpaceCreate".}
proc dSweepAndPruneSpaceCreate*(space: dSpaceID; axisorder: cint): dSpaceID {.
    importc: "dSweepAndPruneSpaceCreate".}
proc dSpaceDestroy*(a1: dSpaceID) {.importc: "dSpaceDestroy".}
proc dHashSpaceSetLevels*(space: dSpaceID; minlevel: cint; maxlevel: cint) {.
    importc: "dHashSpaceSetLevels".}
proc dHashSpaceGetLevels*(space: dSpaceID; minlevel: ptr cint; maxlevel: ptr cint) {.
    importc: "dHashSpaceGetLevels".}
proc dSpaceSetCleanup*(space: dSpaceID; mode: cint) {.importc: "dSpaceSetCleanup".}
proc dSpaceGetCleanup*(space: dSpaceID): cint {.importc: "dSpaceGetCleanup".}
proc dSpaceSetSublevel*(space: dSpaceID; sublevel: cint) {.
    importc: "dSpaceSetSublevel".}
proc dSpaceGetSublevel*(space: dSpaceID): cint {.importc: "dSpaceGetSublevel".}
proc dSpaceSetManualCleanup*(space: dSpaceID; mode: cint) {.
    importc: "dSpaceSetManualCleanup".}
proc dSpaceGetManualCleanup*(space: dSpaceID): cint {.
    importc: "dSpaceGetManualCleanup".}
proc dSpaceAdd*(a1: dSpaceID; a2: dGeomID) {.importc: "dSpaceAdd".}
proc dSpaceRemove*(a1: dSpaceID; a2: dGeomID) {.importc: "dSpaceRemove".}
proc dSpaceQuery*(a1: dSpaceID; a2: dGeomID): cint {.importc: "dSpaceQuery".}
proc dSpaceClean*(a1: dSpaceID) {.importc: "dSpaceClean".}
proc dSpaceGetNumGeoms*(a1: dSpaceID): cint {.importc: "dSpaceGetNumGeoms".}
proc dSpaceGetGeom*(a1: dSpaceID; i: cint): dGeomID {.importc: "dSpaceGetGeom".}
proc dSpaceGetClass*(space: dSpaceID): cint {.importc: "dSpaceGetClass".}
proc dGeomDestroy*(geom: dGeomID) {.importc: "dGeomDestroy".}
proc dGeomSetData*(geom: dGeomID; data: pointer) {.importc: "dGeomSetData".}
proc dGeomGetData*(geom: dGeomID): pointer {.importc: "dGeomGetData".}
proc dGeomSetBody*(geom: dGeomID; body: dBodyID) {.importc: "dGeomSetBody".}
proc dGeomGetBody*(geom: dGeomID): dBodyID {.importc: "dGeomGetBody".}
proc dGeomSetPosition*(geom: dGeomID; x: dReal; y: dReal; z: dReal) {.
    importc: "dGeomSetPosition".}
proc dGeomSetRotation*(geom: dGeomID; R: dMatrix3) {.importc: "dGeomSetRotation".}
proc dGeomSetQuaternion*(geom: dGeomID; Q: dQuaternion) {.
    importc: "dGeomSetQuaternion".}
proc dGeomGetPosition*(geom: dGeomID): ptr dReal {.importc: "dGeomGetPosition".}
proc dGeomCopyPosition*(geom: dGeomID; pos: dVector3) {.importc: "dGeomCopyPosition".}
proc dGeomGetRotation*(geom: dGeomID): ptr dReal {.importc: "dGeomGetRotation".}
proc dGeomCopyRotation*(geom: dGeomID; R: dMatrix3) {.importc: "dGeomCopyRotation".}
proc dGeomGetQuaternion*(geom: dGeomID; result: dQuaternion) {.
    importc: "dGeomGetQuaternion".}
proc dGeomGetAABB*(geom: dGeomID; aabb: array[6, dReal]) {.importc: "dGeomGetAABB".}
proc dGeomIsSpace*(geom: dGeomID): cint {.importc: "dGeomIsSpace".}
proc dGeomGetSpace*(a1: dGeomID): dSpaceID {.importc: "dGeomGetSpace".}
proc dGeomGetClass*(geom: dGeomID): cint {.importc: "dGeomGetClass".}
proc dGeomSetCategoryBits*(geom: dGeomID; bits: culong) {.
    importc: "dGeomSetCategoryBits".}
proc dGeomSetCollideBits*(geom: dGeomID; bits: culong) {.
    importc: "dGeomSetCollideBits".}
proc dGeomGetCategoryBits*(a1: dGeomID): culong {.importc: "dGeomGetCategoryBits".}
proc dGeomGetCollideBits*(a1: dGeomID): culong {.importc: "dGeomGetCollideBits".}
proc dGeomEnable*(geom: dGeomID) {.importc: "dGeomEnable".}
proc dGeomDisable*(geom: dGeomID) {.importc: "dGeomDisable".}
proc dGeomIsEnabled*(geom: dGeomID): cint {.importc: "dGeomIsEnabled".}
proc dGeomLowLevelControl*(geom: dGeomID; controlClass: cint; controlCode: cint;
                          dataValue: pointer; dataSize: ptr cint): cint {.
    importc: "dGeomLowLevelControl".}
proc dGeomGetRelPointPos*(geom: dGeomID; px: dReal; py: dReal; pz: dReal;
                         result: dVector3) {.importc: "dGeomGetRelPointPos".}
proc dGeomGetPosRelPoint*(geom: dGeomID; px: dReal; py: dReal; pz: dReal;
                         result: dVector3) {.importc: "dGeomGetPosRelPoint".}
proc dGeomVectorToWorld*(geom: dGeomID; px: dReal; py: dReal; pz: dReal; result: dVector3) {.
    importc: "dGeomVectorToWorld".}
proc dGeomVectorFromWorld*(geom: dGeomID; px: dReal; py: dReal; pz: dReal;
                          result: dVector3) {.importc: "dGeomVectorFromWorld".}
proc dGeomSetOffsetPosition*(geom: dGeomID; x: dReal; y: dReal; z: dReal) {.
    importc: "dGeomSetOffsetPosition".}
proc dGeomSetOffsetRotation*(geom: dGeomID; R: dMatrix3) {.
    importc: "dGeomSetOffsetRotation".}
proc dGeomSetOffsetQuaternion*(geom: dGeomID; Q: dQuaternion) {.
    importc: "dGeomSetOffsetQuaternion".}
proc dGeomSetOffsetWorldPosition*(geom: dGeomID; x: dReal; y: dReal; z: dReal) {.
    importc: "dGeomSetOffsetWorldPosition".}
proc dGeomSetOffsetWorldRotation*(geom: dGeomID; R: dMatrix3) {.
    importc: "dGeomSetOffsetWorldRotation".}
proc dGeomSetOffsetWorldQuaternion*(geom: dGeomID; a2: dQuaternion) {.
    importc: "dGeomSetOffsetWorldQuaternion".}
proc dGeomClearOffset*(geom: dGeomID) {.importc: "dGeomClearOffset".}
proc dGeomIsOffset*(geom: dGeomID): cint {.importc: "dGeomIsOffset".}
proc dGeomGetOffsetPosition*(geom: dGeomID): ptr dReal {.
    importc: "dGeomGetOffsetPosition".}
proc dGeomCopyOffsetPosition*(geom: dGeomID; pos: dVector3) {.
    importc: "dGeomCopyOffsetPosition".}
proc dGeomGetOffsetRotation*(geom: dGeomID): ptr dReal {.
    importc: "dGeomGetOffsetRotation".}
proc dGeomCopyOffsetRotation*(geom: dGeomID; R: dMatrix3) {.
    importc: "dGeomCopyOffsetRotation".}
proc dGeomGetOffsetQuaternion*(geom: dGeomID; result: dQuaternion) {.
    importc: "dGeomGetOffsetQuaternion".}
proc dCollide*(o1: dGeomID; o2: dGeomID; flags: cint; contact: ptr dContactGeom;
              skip: cint): cint {.importc: "dCollide".}
proc dSpaceCollide*(space: dSpaceID; data: pointer; callback: ptr dNearCallback) {.
    importc: "dSpaceCollide".}
proc dSpaceCollide2*(space1: dGeomID; space2: dGeomID; data: pointer;
                    callback: ptr dNearCallback) {.importc: "dSpaceCollide2".}
proc dCreateSphere*(space: dSpaceID; radius: dReal): dGeomID {.
    importc: "dCreateSphere".}
proc dGeomSphereSetRadius*(sphere: dGeomID; radius: dReal) {.
    importc: "dGeomSphereSetRadius".}
proc dGeomSphereGetRadius*(sphere: dGeomID): dReal {.importc: "dGeomSphereGetRadius".}
proc dGeomSpherePointDepth*(sphere: dGeomID; x: dReal; y: dReal; z: dReal): dReal {.
    importc: "dGeomSpherePointDepth".}
proc dCreateConvex*(space: dSpaceID; planes: ptr dReal; planecount: cuint;
                   points: ptr dReal; pointcount: cuint; polygons: ptr cuint): dGeomID {.
    importc: "dCreateConvex".}
proc dGeomSetConvex*(g: dGeomID; planes: ptr dReal; count: cuint; points: ptr dReal;
                    pointcount: cuint; polygons: ptr cuint) {.
    importc: "dGeomSetConvex".}
proc dCreateBox*(space: dSpaceID; lx: dReal; ly: dReal; lz: dReal): dGeomID {.
    importc: "dCreateBox".}
proc dGeomBoxSetLengths*(box: dGeomID; lx: dReal; ly: dReal; lz: dReal) {.
    importc: "dGeomBoxSetLengths".}
proc dGeomBoxGetLengths*(box: dGeomID; result: dVector3) {.
    importc: "dGeomBoxGetLengths".}
proc dGeomBoxPointDepth*(box: dGeomID; x: dReal; y: dReal; z: dReal): dReal {.
    importc: "dGeomBoxPointDepth".}
proc dCreatePlane*(space: dSpaceID; a: dReal; b: dReal; c: dReal; d: dReal): dGeomID {.
    importc: "dCreatePlane".}
proc dGeomPlaneSetParams*(plane: dGeomID; a: dReal; b: dReal; c: dReal; d: dReal) {.
    importc: "dGeomPlaneSetParams".}
proc dGeomPlaneGetParams*(plane: dGeomID; result: dVector4) {.
    importc: "dGeomPlaneGetParams".}
proc dGeomPlanePointDepth*(plane: dGeomID; x: dReal; y: dReal; z: dReal): dReal {.
    importc: "dGeomPlanePointDepth".}
proc dCreateCapsule*(space: dSpaceID; radius: dReal; length: dReal): dGeomID {.
    importc: "dCreateCapsule".}
proc dGeomCapsuleSetParams*(ccylinder: dGeomID; radius: dReal; length: dReal) {.
    importc: "dGeomCapsuleSetParams".}
proc dGeomCapsuleGetParams*(ccylinder: dGeomID; radius: ptr dReal; length: ptr dReal) {.
    importc: "dGeomCapsuleGetParams".}
proc dGeomCapsulePointDepth*(ccylinder: dGeomID; x: dReal; y: dReal; z: dReal): dReal {.
    importc: "dGeomCapsulePointDepth".}
proc dCreateCylinder*(space: dSpaceID; radius: dReal; length: dReal): dGeomID {.
    importc: "dCreateCylinder".}
proc dGeomCylinderSetParams*(cylinder: dGeomID; radius: dReal; length: dReal) {.
    importc: "dGeomCylinderSetParams".}
proc dGeomCylinderGetParams*(cylinder: dGeomID; radius: ptr dReal; length: ptr dReal) {.
    importc: "dGeomCylinderGetParams".}
proc dCreateRay*(space: dSpaceID; length: dReal): dGeomID {.importc: "dCreateRay".}
proc dGeomRaySetLength*(ray: dGeomID; length: dReal) {.importc: "dGeomRaySetLength".}
proc dGeomRayGetLength*(ray: dGeomID): dReal {.importc: "dGeomRayGetLength".}
proc dGeomRaySet*(ray: dGeomID; px: dReal; py: dReal; pz: dReal; dx: dReal; dy: dReal;
                 dz: dReal) {.importc: "dGeomRaySet".}
proc dGeomRayGet*(ray: dGeomID; start: dVector3; dir: dVector3) {.
    importc: "dGeomRayGet".}
proc dGeomRaySetFirstContact*(g: dGeomID; firstContact: cint) {.
    importc: "dGeomRaySetFirstContact".}
proc dGeomRayGetFirstContact*(g: dGeomID): cint {.importc: "dGeomRayGetFirstContact".}
proc dGeomRaySetBackfaceCull*(g: dGeomID; backfaceCull: cint) {.
    importc: "dGeomRaySetBackfaceCull".}
proc dGeomRayGetBackfaceCull*(g: dGeomID): cint {.importc: "dGeomRayGetBackfaceCull".}
proc dGeomRaySetClosestHit*(g: dGeomID; closestHit: cint) {.
    importc: "dGeomRaySetClosestHit".}
proc dGeomRayGetClosestHit*(g: dGeomID): cint {.importc: "dGeomRayGetClosestHit".}
proc dCreateHeightfield*(space: dSpaceID; data: dHeightfieldDataID; bPlaceable: cint): dGeomID {.
    importc: "dCreateHeightfield".}
proc dGeomHeightfieldDataCreate*(): dHeightfieldDataID {.
    importc: "dGeomHeightfieldDataCreate".}
proc dGeomHeightfieldDataDestroy*(d: dHeightfieldDataID) {.
    importc: "dGeomHeightfieldDataDestroy".}
proc dGeomHeightfieldDataBuildCallback*(d: dHeightfieldDataID; pUserData: pointer;
                                       pCallback: ptr dHeightfieldGetHeight;
                                       width: dReal; depth: dReal;
                                       widthSamples: cint; depthSamples: cint;
                                       scale: dReal; offset: dReal;
                                       thickness: dReal; bWrap: cint) {.
    importc: "dGeomHeightfieldDataBuildCallback".}
proc dGeomHeightfieldDataBuildByte*(d: dHeightfieldDataID; pHeightData: ptr cuchar;
                                   bCopyHeightData: cint; width: dReal;
                                   depth: dReal; widthSamples: cint;
                                   depthSamples: cint; scale: dReal; offset: dReal;
                                   thickness: dReal; bWrap: cint) {.
    importc: "dGeomHeightfieldDataBuildByte".}
proc dGeomHeightfieldDataBuildShort*(d: dHeightfieldDataID;
                                    pHeightData: ptr cshort; bCopyHeightData: cint;
                                    width: dReal; depth: dReal; widthSamples: cint;
                                    depthSamples: cint; scale: dReal; offset: dReal;
                                    thickness: dReal; bWrap: cint) {.
    importc: "dGeomHeightfieldDataBuildShort".}
proc dGeomHeightfieldDataBuildSingle*(d: dHeightfieldDataID;
                                     pHeightData: ptr cfloat;
                                     bCopyHeightData: cint; width: dReal;
                                     depth: dReal; widthSamples: cint;
                                     depthSamples: cint; scale: dReal;
                                     offset: dReal; thickness: dReal; bWrap: cint) {.
    importc: "dGeomHeightfieldDataBuildSingle".}
proc dGeomHeightfieldDataBuildDouble*(d: dHeightfieldDataID;
                                     pHeightData: ptr cdouble;
                                     bCopyHeightData: cint; width: dReal;
                                     depth: dReal; widthSamples: cint;
                                     depthSamples: cint; scale: dReal;
                                     offset: dReal; thickness: dReal; bWrap: cint) {.
    importc: "dGeomHeightfieldDataBuildDouble".}
proc dGeomHeightfieldDataSetBounds*(d: dHeightfieldDataID; minHeight: dReal;
                                   maxHeight: dReal) {.
    importc: "dGeomHeightfieldDataSetBounds".}
proc dGeomHeightfieldSetHeightfieldData*(g: dGeomID; d: dHeightfieldDataID) {.
    importc: "dGeomHeightfieldSetHeightfieldData".}
proc dGeomHeightfieldGetHeightfieldData*(g: dGeomID): dHeightfieldDataID {.
    importc: "dGeomHeightfieldGetHeightfieldData".}
proc dClosestLineSegmentPoints*(a1: dVector3; a2: dVector3; b1: dVector3; b2: dVector3;
                               cp1: dVector3; cp2: dVector3) {.
    importc: "dClosestLineSegmentPoints".}
proc dBoxTouchesBox*(p1: dVector3; R1: dMatrix3; side1: dVector3; p2: dVector3;
                    R2: dMatrix3; side2: dVector3): cint {.importc: "dBoxTouchesBox".}
proc dBoxBox*(p1: dVector3; R1: dMatrix3; side1: dVector3; p2: dVector3; R2: dMatrix3;
             side2: dVector3; normal: dVector3; depth: ptr dReal;
             return_code: ptr cint; flags: cint; contact: ptr dContactGeom; skip: cint): cint {.
    importc: "dBoxBox".}
proc dInfiniteAABB*(geom: dGeomID; aabb: array[6, dReal]) {.importc: "dInfiniteAABB".}
proc dCreateGeomClass*(classptr: ptr dGeomClass): cint {.importc: "dCreateGeomClass".}
proc dGeomGetClassData*(a1: dGeomID): pointer {.importc: "dGeomGetClassData".}
proc dCreateGeom*(classnum: cint): dGeomID {.importc: "dCreateGeom".}
proc dSetColliderOverride*(i: cint; j: cint; fn: ptr dColliderFn) {.
    importc: "dSetColliderOverride".}
proc dThreadingAllocateSelfThreadedImplementation*(): dThreadingImplementationID {.
    importc: "dThreadingAllocateSelfThreadedImplementation".}
proc dThreadingAllocateMultiThreadedImplementation*(): dThreadingImplementationID {.
    importc: "dThreadingAllocateMultiThreadedImplementation".}
proc dThreadingImplementationGetFunctions*(impl: dThreadingImplementationID): ptr dThreadingFunctionsInfo {.
    importc: "dThreadingImplementationGetFunctions".}
proc dThreadingImplementationShutdownProcessing*(impl: dThreadingImplementationID) {.
    importc: "dThreadingImplementationShutdownProcessing".}
proc dThreadingImplementationCleanupForRestart*(impl: dThreadingImplementationID) {.
    importc: "dThreadingImplementationCleanupForRestart".}
proc dThreadingFreeImplementation*(impl: dThreadingImplementationID) {.
    importc: "dThreadingFreeImplementation".}
proc dExternalThreadingServeMultiThreadedImplementation*(
    impl: dThreadingImplementationID; readiness_callback: ptr dThreadReadyToServeCallback; ## =NULL
    callback_context: pointer) {.importc: "dExternalThreadingServeMultiThreadedImplementation".}
  ## =NULL
proc dThreadingAllocateThreadPool*(thread_count: cuint; stack_size: dsizeint;
                                  ode_data_allocate_flags: cuint; reserved: pointer): dThreadingThreadPoolID {.
    importc: "dThreadingAllocateThreadPool".}
  ## =NULL
proc dThreadingThreadPoolServeMultiThreadedImplementation*(
    pool: dThreadingThreadPoolID; impl: dThreadingImplementationID) {.
    importc: "dThreadingThreadPoolServeMultiThreadedImplementation".}
proc dThreadingThreadPoolWaitIdleState*(pool: dThreadingThreadPoolID) {.
    importc: "dThreadingThreadPoolWaitIdleState".}
proc dThreadingFreeThreadPool*(pool: dThreadingThreadPoolID) {.
    importc: "dThreadingFreeThreadPool".}
proc dCooperativeCreate*(functionInfo: ptr dThreadingFunctionsInfo; ## =NULL
                        threadingImpl: dThreadingImplementationID): dCooperativeID {.
    importc: "dCooperativeCreate".}
  ## =NULL
proc dCooperativeDestroy*(cooperative: dCooperativeID) {.
    importc: "dCooperativeDestroy".}
proc dResourceRequirementsCreate*(cooperative: dCooperativeID): dResourceRequirementsID {.
    importc: "dResourceRequirementsCreate".}
proc dResourceRequirementsDestroy*(requirements: dResourceRequirementsID) {.
    importc: "dResourceRequirementsDestroy".}
proc dResourceRequirementsClone*(requirements: dResourceRequirementsID): dResourceRequirementsID {.
    importc: "dResourceRequirementsClone".}
  ## const
proc dResourceRequirementsMergeIn*(summaryRequirements: dResourceRequirementsID;
                                  extraRequirements: dResourceRequirementsID) {.
    importc: "dResourceRequirementsMergeIn".}
  ## const
proc dResourceContainerAcquire*(requirements: dResourceRequirementsID): dResourceContainerID {.
    importc: "dResourceContainerAcquire".}
  ## const
proc dResourceContainerDestroy*(resources: dResourceContainerID) {.
    importc: "dResourceContainerDestroy".}
proc dWorldExportDIF*(w: dWorldID; file: ptr FILE; world_name: cstring) {.
    importc: "dWorldExportDIF".}
