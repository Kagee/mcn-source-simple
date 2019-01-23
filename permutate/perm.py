#! /usr/bin/env python3

import itertools
import sys

if len(sys.argv) < 2:
    print("missing repeat argument and/or non-ascii chars")
    sys.exit()

text = "abcdefghijklmnopqrstuvwxyz{}0123456789-".format(
        "".join(c[0] for c in sys.argv[2])
        )
for perm in itertools.product(list(text), repeat=int(sys.argv[1])):
    print("".join(perm) + ".no")
