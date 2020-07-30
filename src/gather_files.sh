#!/bin/bash

if [ $# -ne 3 ]; then
    echo "usage: $0 <processing script eg. en.sh, es.sh, cs.sh> <full-path to input direcotry to be processed> <dataset name>"
    exit
fi


lang=$(basename "$1" | cut -d. -f1)
PRE=$2
suffix=$3
filename="process_${lang}_${suffix}.sh"

if [ -f "$filename" ]; then
  rm -rf $filename
fi


# remove old run2transcript.sh file
if [ -f run2transcript.sh ]; then
  rm -rf run2transcript.sh
  else
    touch run2transcript.sh
    chmod a+x run2transcript.sh

fi




for i in $PRE/*.wav; do
    echo $i
    echo "./en.sh $i" >> ${filename}
done

chmod a+x $filename
REF_DIR=$2