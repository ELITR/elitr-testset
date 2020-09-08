#!/bin/bash

'''
Search recursively for WAV files in the given dir and prepare task files to generate ASR logs.
'''

if [ $# -ne 3 ]; then
    echo "usage: $0 <processing script eg. en.sh, es.sh, cs.sh> <full-path to input direcotry to be processed> <dataset name>"
    exit
fi


lang=$(basename "$1" | cut -d. -f1)
PRE=$2
suffix=$3
filename="process_${lang}_${suffix}.tsk"

if [ -f "$filename" ]; then
  rm -rf $filename
fi


# remove old run2transcript-${FROM_S}.tsk file
FROM_S=${lang^^}
if [ -f run2transcript-${FROM_S}.tsk ]; then
  rm -rf run2transcript-${FROM_S}.tsk
  else
    touch run2transcript-${FROM_S}.tsk
    chmod a+x run2transcript-${FROM_S}.tsk

fi


for i in $(find $PRE -maxdepth 10 -type f -name "*.wav"); do
    echo $i
    echo "./$1 $i" >> ${filename}.tmp
done
sort ${filename}.tmp > ${filename}
rm -rf ${filename}.tmp
chmod a+x $filename
