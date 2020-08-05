#!/bin/bash

mt=$1
ostt=$2
tt=$3
ref_align="$mt.align"

cd ./src/SLTev
python3 SLTev.py --ostt ../../$ostt --tt ../../$tt --mt ../../$mt --align ../../$ref_align --b_time 3000 > ../../$mt.eval
