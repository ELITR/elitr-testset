#!/bin/bash
import sys
for l in sys.stdin:
    print(l.lower().strip())
    sys.stdout.flush()
