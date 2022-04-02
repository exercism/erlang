#!/usr/bin/env python3

import sys
import json

lines = [l.strip() for l in sys.stdin]
splits = [l.split(".") for l in lines]

versions = {}
for major, minor in splits:
    versions[major] = versions.get(major, []) + [minor]

maxes = ["{}.{}".format(major, max(minors)) for major, minors in versions.items()]

print(json.dumps(maxes))