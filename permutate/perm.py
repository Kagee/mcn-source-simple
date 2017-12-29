#! /usr/bin/env python3
# coding: utf-8

import itertools
import sys

if len(sys.argv) < 2:
    print("missing repeat argument and/or mcm tools path")
    sys.exit()

sys.path.append(sys.argv[2])
from build_regexp import *

print(sys.argv[1], sys.argv[2], file=sys.stderr)

sys.exit()
#text="abcdefghijklmnopqrstuvwxyzáàäčçđéèêŋńñóòôöšŧüžæøå0123456789-"

text=u"abcdefghijklmnopqrstuvwxyzæøå0123456789-"

for perm in itertools.product(list(text), repeat=int(sys.argv[1])):
    print("".join(perm) + ".no").encode('utf-8')
