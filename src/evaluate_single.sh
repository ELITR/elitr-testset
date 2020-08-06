#!/bin/bash

mt=$1
ostt=$2
tt=$3
ref_align="$mt.align" #a file always in the same directory as mt, with additional extension

cd ./src/SLTev
python3 SLTev.py --ostt ../../$ostt --tt ../../$tt --mt ../../$mt --align ../../$ref_align --b_time 3000 > ../../"$mt.eval"
