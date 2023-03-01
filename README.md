# ode-nim

Nim bindings for Open Dynamics Engine

## Build

Functions are generated using the nix build, but the contents of types.h is hand
copied.

## TODO

define the following types:

```nix
  types = [
    "dReal"
    "dColliderFn"
    "dGeomID"
    "dGeomClass"

    "dVector3"
    "dMatrix3"
    "dHeightfieldDataID"
    "dSpaceID"
    "dVector4"
    "dNearCallback"
    "dContactGeom"
    "dQuaternion"

    # error stuff
    "dMessage"
    "dError"
    "dDebug"
    "dMessageFunction"

    "dBodyID"
    "dJointID"
    "dJointFeedback"
    "dJointType"
    "dJointGroupID"
    "dContact"
    "dMass"
    "dWorldID"
    "dWorldQuickStepIterationCount_DynamicAdjustmentStatistics"
    "dThreadingFunctionsInfo"
    "dThreadingImplementationID"
    "dWorldStepMemoryFunctionsInfo"
    "dWorldStepReserveInfo"

    # cooperative.h
    "dResourceContainerID"
    "dResourceRequirementsID"
    "dCooperativeID"

    # memory
    "dsizeint"
    "dAllocFunction"
    "dReallocFunction"
    "dFreeFunction"
    "dStopwatch"

    # trimesh
    "dTriMeshDataID"
    "dTriRayCallback"
    "dTriArrayCallback"
    "dTriCallback"
    "dTriTriMergeCallback"
    "dMatrix4"

    # ode collision_util
    "dInfiniteAABB"
    "dxGeom"
  ];
```
