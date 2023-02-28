#!/bin/python3

import sys
import os
import re

files = [
    "odeconfig.h",
    "compatibility.h",
    "common.h",
    "odeinit.h",
    "contact.h",
    "error.h",
    "memory.h",
    "odemath.h",
    "matrix.h",
    "matrix_coop.h",
    "timer.h",
    "rotation.h",
    "mass.h",
    "misc.h",
    "objects.h",
    "collision_space.h",
    "collision.h",
    "threading.h",
    "threading_impl.h",
    "cooperative.h",
    "export-dif.h",
    "version.h.in",
]

root = sys.argv[1]
output = sys.argv[2]

if not os.path.exists(root):
    print(f"no known directory {root}")
    exit(1)
print(f"root directory {root} valid...")

output_dir = os.path.dirname(output)
if not os.path.exists(output_dir):
    print(f"no known file or directory {os.path.dirname(output)}")
    exit(1)

print(f"output directory {os.path.dirname(output)} valid...")


# go through lines, looking for ODE_API
def proc_header(hfile):
    o = open(output, "a")
    in_multiline_state = False
    cache = ""
    for line in hfile:
        if not in_multiline_state:
            # check if its a ODE_API entry at all
            ode_api_entry = re.search(r"^ODE_API ", line)
            if ode_api_entry is None:
                continue
        # ensure there is a semicolon
        semicolon_endl = re.search(r".*?;(\s*?)$", line)

        # check if we are leaving multiline state
        if in_multiline_state and semicolon_endl != None:
            cache += line
            o.write(cache)
            cache = ""
            in_multiline_state = False
            continue
        # check if we are ENTERING multiline state, or continuing it
        elif semicolon_endl is None:
            in_multiline_state = True
            cache += line
            continue

        # otherwise, we are definitely not in multiline state and there is
        # a semicolon.
        o.write(line)

    o.close()

for header in files:
    with open(os.path.join(root, header), "r") as hfile:
        proc_header(hfile)
