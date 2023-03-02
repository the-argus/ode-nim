#include "ode/ode.h"
#include <stdio.h>

const float stepSize = 0.03f;

// initialize ODE and world

int main () {
    dInitODE2(0);
    dWorldID world = dWorldCreate();
    dWorldSetGravity(world, 0, -9, 0);

    dBodyID body = dBodyCreate(world);
    dMass mass;
    dBodySetPosition(body, 0, 10, 0);
    dMassSetBox(&mass, 2, 1, 1, 1);
    // im not really sure why theres the "newmass" param... shouldnt that be implicit
    // from the density and size being given already?
    dMassAdjust(&mass, 0.1);
    // apply this mass to the body
    dBodySetMass(body, &mass);

    const dReal* bodyPos; 
    bodyPos = dBodyGetPosition(body);

    printf("x: %f\ty: %f\tz: %f\n", bodyPos[0], bodyPos[1], bodyPos[2]);

    dWorldStep(world, stepSize);
    
    bodyPos = dBodyGetPosition(body);
    printf("x: %f\ty: %f\tz: %f\n", bodyPos[0], bodyPos[1], bodyPos[2]);

    // cleanup
    dBodyDestroy(body);
    dWorldDestroy(world);
    dCloseODE();
}
