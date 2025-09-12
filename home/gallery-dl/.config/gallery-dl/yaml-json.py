#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import yaml, json, sys

with open(sys.argv[1]) as fp:
    data = yaml.safe_load(fp.read())

json.dump(data, sys.stdout, indent=2)
print("\n")

