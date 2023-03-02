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
