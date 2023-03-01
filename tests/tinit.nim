import ode

let world = ode.dWorldCreate()

world.dWorldSetGravity(0, -9, 0)

let body = world.dBodyCreate()

# cleanup
ode.dBodyDestroy(body)
ode.dWorldDestroy(world)
