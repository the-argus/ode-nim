import ode

const stepSize = 0.03

# initialize ODE and world
discard ode.dInitODE2(0)
let world = ode.dWorldCreate()
world.dWorldSetGravity(0, -9, 0)

let body = world.dBodyCreate()
let mass = dMass()
body.dBodySetPosition(0, 10, 0)
# 1x1x1 box, density of 2
dMassSetBox(unsafeAddr mass, 2, 1, 1, 1)
# im not really sure why theres the "newmass" param... shouldnt that be implicit
# from the density and size being given already?
dMassAdjust(unsafeAddr mass, 0.1)
# apply this mass to the body
body.dBodySetMass(unsafeAddr mass)

let bodyPos = cast[array[3, dReal]](body.dBodyGetPosition())

echo "x: " & $cdouble(bodyPos[0]) & "\ty: " & $cdouble(bodyPos[0]) & "\tz: " & $cdouble(bodyPos[0])

discard world.dWorldStep(stepSize)

echo "x: " & $cdouble(bodyPos[0]) & "\ty: " & $cdouble(bodyPos[0]) & "\tz: " & $cdouble(bodyPos[0])

# cleanup
ode.dBodyDestroy(body)
ode.dWorldDestroy(world)
ode.dCloseODE()
