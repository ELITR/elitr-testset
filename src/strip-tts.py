#!/bin/bash
import sys
for l in sys.stdin:
    print(" ".join(l.split()[1:]))
    sys.stdout.flush()