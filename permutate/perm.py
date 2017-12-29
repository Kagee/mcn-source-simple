#! /usr/bin/env python3

import itertools
import sys

if len(sys.argv) < 2:
    print("missing repeat argument and/or mcm tools path")
    sys.exit()

sys.path.append(sys.argv[2])
from build_regexp import *

chars = get_non_ascii(prod=False, python=True) 

text = "abcdefghijklmnopqrstuvwxyz{}0123456789-".format(
        "".join(c[0] for c in chars)
        )

for perm in itertools.product(list(text), repeat=int(sys.argv[1])):
    print("".join(perm) + ".no")
