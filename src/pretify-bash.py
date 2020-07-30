#!/usr/bin/env python3

# by Dominik
# this pretifies our bash command with lots of pipes and tee redirections into more readable format
# (tested only on one example)

import sys

for line in sys.stdin:
    toks = line.split()
    newtoks = []
    indents = []
    for t in toks:
        if t == "|":
            newtoks += [t, "\n"] + indents
        elif t == ">(":
            indents += ["\t"]
            newtoks += [t,"\n"]+indents
        elif t == ")":
            indents = indents[:-1]
            newtoks += [t]
        else:
            newtoks += [t]

    print(" ".join(newtoks))            

