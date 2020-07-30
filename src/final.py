#!/usr/bin/env python3
import sys
k = set()
d = {}
f = {}
m = 0
for i in sys.stdin:
    if not i.strip(): continue
    a,b,*rest = i.split()
    e = int(a)
    c = int(b)
    d[(e,c)] = [a,b,*rest]
    # tohle je chyba, má být 
    # f[e] = c každopádně. Protože ke konci se 10 může přepsat na 1, což je ta poslední hypotéza...
    f[e] = c
    k.add(e)
    m = e

    

for i in sorted(list(k)):
    if i > m: continue
    b = f[i]
    print(" ".join(d[(i,b)]))
