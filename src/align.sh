#!/bin/bash

mt=$1
ostt=$2
tt=$3
path=$4

cd ./src/SLTev
python3 giza++/transcript_to_source.py ../../$ostt > source_ref
cd giza-pp/run_giza

mv ../../source_ref .
cp ../../../../$tt tt
bash run.sh tt source_ref ./out_folder
cat out_folder/Result.A3.final > ../../../../$mt.align
