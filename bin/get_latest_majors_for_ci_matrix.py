#!/usr/bin/env python3

"""
This script receives a newline separated list of major/minor versions on its
stdin and produces a JSON list of major/minor versions.

The returned list will only contain the latest minor release for each major
release.

This is used in the CI scripts to create a buildmatrix that contains the latest
minors of the last 3 to 4 majors.
"""

import sys
import json

lines = [l.strip() for l in sys.stdin]
splits = [l.split(".") for l in lines]

versions = {}
for major, minor in splits:
    versions[major] = versions.get(major, []) + [minor]

maxes = ["{}.{}".format(major, max(minors)) for major, minors in versions.items()]

print(json.dumps(maxes))