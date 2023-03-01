#include <bits/types.h>
#include <stdarg.h>
#include <stddef.h>
#include <stdio.h>

#ifdef __USE_TIME_BITS64
typedef __time64_t time_t;
#else
typedef __time_t time_t;
#endif

// BASIC NUMBER TYPES
typedef int dint32;
typedef unsigned int duint32;
typedef short dint16;
typedef unsigned short duint16;
typedef signed char dint8;
typedef unsigned char duint8;

typedef long long dint64;
// TODO: replace this with "culonglong" in nim code, c2nim doesnt work
typedef unsigned long long duint64;

typedef dint64 dintptr;
typedef duint64 duintptr;
typedef dint64 ddiffint;
typedef duint64 dsizeint;

typedef void dMessageFunction(int errnum, const char *msg, va_list ap);
typedef void *dAllocFunction(dsizeint size);
typedef void *dReallocFunction(void *ptr, dsizeint oldsize, dsizeint newsize);
typedef void dFreeFunction(void *ptr, dsizeint size);
typedef double dReal;
typedef dReal dVector3[3];
typedef dReal dVector4[4];
typedef dReal dMatrix3[9];
struct dxResourceRequirements;
struct dxResourceContainer;
typedef struct dxResourceRequirements *dResourceRequirementsID;
typedef struct dxResourceContainer *dResourceContainerID;
typedef struct dStopwatch {
  double time;
  unsigned long cc[2];
} dStopwatch;
typedef dReal dQuaternion[4];
struct dMass;
typedef struct dMass dMass;
struct dxWorld;
struct dxSpace;
struct dxBody;
struct dxGeom;
struct dxJoint;
struct dxJointGroup;
typedef struct dxWorld *dWorldID;
typedef struct dxSpace *dSpaceID;
typedef struct dxBody *dBodyID;
typedef struct dxGeom *dGeomID;
typedef struct dxJoint *dJointID;
typedef struct dxJointGroup *dJointGroupID;
typedef struct {
  unsigned struct_size;
  float reserve_factor;
  unsigned reserve_minimum;

} dWorldStepReserveInfo;

typedef struct {
  unsigned struct_size;
  void *(*alloc_block)(dsizeint block_size);
  void *(*shrink_block)(void *block_pointer, dsizeint block_current_size,
                        dsizeint block_smaller_size);
  void (*free_block)(void *block_pointer, dsizeint block_current_size);

} dWorldStepMemoryFunctionsInfo;

struct dxMutexGroup;
typedef struct dxMutexGroup *dMutexGroupID;
struct dxThreadingImplementation;
typedef struct dxThreadingImplementation *dThreadingImplementationID;
typedef unsigned dmutexindex_t;
typedef dsizeint ddependencycount_t;
typedef dsizeint dcallindex_t;
struct dxCallWait;
typedef struct dxCallWait *dCallWaitID;
struct dxCallReleasee;
typedef struct dxCallReleasee *dCallReleaseeID;
typedef ddiffint ddependencychange_t;

typedef int dThreadedCallFunction(void *call_context,
                                  dcallindex_t instance_index,
                                  dCallReleaseeID this_releasee);

typedef struct dxThreadedWaitTime {
  time_t wait_sec;
  unsigned long wait_nsec;

} dThreadedWaitTime;

typedef dMutexGroupID
dMutexGroupAllocFunction(dThreadingImplementationID impl,
                         dmutexindex_t Mutex_count,
                         const char *const *Mutex_names_ptr);
typedef void dMutexGroupFreeFunction(dThreadingImplementationID impl,
                                     dMutexGroupID mutex_group);
typedef void dMutexGroupMutexLockFunction(dThreadingImplementationID impl,
                                          dMutexGroupID mutex_group,
                                          dmutexindex_t mutex_index);
typedef void dMutexGroupMutexUnlockFunction(dThreadingImplementationID impl,
                                            dMutexGroupID mutex_group,
                                            dmutexindex_t mutex_index);
typedef dCallWaitID
dThreadedCallWaitAllocFunction(dThreadingImplementationID impl);
typedef void dThreadedCallWaitResetFunction(dThreadingImplementationID impl,
                                            dCallWaitID call_wait);
typedef void dThreadedCallWaitFreeFunction(dThreadingImplementationID impl,
                                           dCallWaitID call_wait);
typedef void dThreadedCallPostFunction(
    dThreadingImplementationID impl, int *out_summary_fault,
    dCallReleaseeID *out_post_releasee, ddependencycount_t dependencies_count,
    dCallReleaseeID dependent_releasee, dCallWaitID call_wait,
    dThreadedCallFunction *call_func, void *call_context,
    dcallindex_t instance_index, const char *call_name);
typedef void dThreadedCallDependenciesCountAlterFunction(
    dThreadingImplementationID impl, dCallReleaseeID target_releasee,
    ddependencychange_t dependencies_count_change);
typedef void
dThreadedCallWaitFunction(dThreadingImplementationID impl, int *out_wait_status,
                          dCallWaitID call_wait,
                          const dThreadedWaitTime *timeout_time_ptr,
                          const char *wait_name);
typedef unsigned
dThreadingImplThreadCountRetrieveFunction(dThreadingImplementationID impl);
typedef int dThreadingImplResourcesForCallsPreallocateFunction(
    dThreadingImplementationID impl,
    ddependencycount_t max_simultaneous_calls_estimate);

typedef struct dxThreadingFunctionsInfo {
  unsigned struct_size;

  dMutexGroupAllocFunction *alloc_mutex_group;
  dMutexGroupFreeFunction *free_mutex_group;
  dMutexGroupMutexLockFunction *lock_group_mutex;
  dMutexGroupMutexUnlockFunction *unlock_group_mutex;

  dThreadedCallWaitAllocFunction *alloc_call_wait;
  dThreadedCallWaitResetFunction *reset_call_wait;
  dThreadedCallWaitFreeFunction *free_call_wait;

  dThreadedCallPostFunction *post_call;
  dThreadedCallDependenciesCountAlterFunction *alter_call_dependencies_count;
  dThreadedCallWaitFunction *wait_call;

  dThreadingImplThreadCountRetrieveFunction *retrieve_thread_count;
  dThreadingImplResourcesForCallsPreallocateFunction
      *preallocate_resources_for_calls;
} dThreadingFunctionsInfo;

typedef struct {
  unsigned struct_size;

  duint32 iteration_count;

  duint32 premature_exits;
  duint32 prolonged_execs;
  duint32 full_extra_execs;
} dWorldQuickStepIterationCount_DynamicAdjustmentStatistics;

typedef struct dContactGeom {
  dVector3 pos;
  dVector3 normal;
  dReal depth;
  dGeomID g1, g2;
  int side1, side2;
} dContactGeom;
typedef struct dSurfaceParameters {
  int mode;
  dReal mu;
  dReal mu2;
  dReal rho;
  dReal rho2;
  dReal rhoN;
  dReal bounce;
  dReal bounce_vel;
  dReal soft_erp;
  dReal soft_cfm;
  dReal motion1, motion2, motionN;
  dReal slip1, slip2;
} dSurfaceParameters;

typedef struct dContact {
  dSurfaceParameters surface;
  dContactGeom geom;
  dVector3 fdir1;
} dContact;

typedef enum {
  dJointTypeNone = 0,
  dJointTypeBall,
  dJointTypeHinge,
  dJointTypeSlider,
  dJointTypeContact,
  dJointTypeUniversal,
  dJointTypeHinge2,
  dJointTypeFixed,
  dJointTypeNull,
  dJointTypeAMotor,
  dJointTypeLMotor,
  dJointTypePlane2D,
  dJointTypePR,
  dJointTypePU,
  dJointTypePiston,
  dJointTypeDBall,
  dJointTypeDHinge,
  dJointTypeTransmission,
} dJointType;

typedef struct dJointFeedback {
  dVector3 f1;
  dVector3 t1;
  dVector3 f2;
  dVector3 t2;
} dJointFeedback;

typedef void dNearCallback(void *data, dGeomID o1, dGeomID o2);

struct dxHeightfieldData;
typedef struct dxHeightfieldData *dHeightfieldDataID;

typedef dReal dHeightfieldGetHeight(void *p_user_data, int x, int z);

typedef void dGetAABBFn(dGeomID, dReal aabb[6]);
typedef int dColliderFn(dGeomID o1, dGeomID o2, int flags,
                        dContactGeom *contact, int skip);
typedef dColliderFn *dGetColliderFnFn(int num);
typedef void dGeomDtorFn(dGeomID o);
typedef int dAABBTestFn(dGeomID o1, dGeomID o2, dReal aabb[6]);
typedef struct dGeomClass {
  int bytes;
  dGetColliderFnFn *collider;
  dGetAABBFn *aabb;
  dAABBTestFn *aabb_test;
  dGeomDtorFn *dtor;
} dGeomClass;

typedef void(dThreadReadyToServeCallback)(void *callback_context);

struct dxThreadingThreadPool;
typedef struct dxThreadingThreadPool *dThreadingThreadPoolID;

struct dxCooperative;
typedef struct dxCooperative *dCooperativeID;
