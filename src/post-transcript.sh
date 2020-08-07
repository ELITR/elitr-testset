#!/bin/bash

if [ $# -ne 2 ] ; then
    echo "usage: $0 <input dir with logs> <dir containing reference transcripts>"
    exit
fi

REF_DIR=$2
DIR=$1
filename=$(echo $DIR | rev | cut -d"." -f2- | rev)
TRDIR="${filename}.transcript" # Transcript dir

# ASR Transcripts
for i in $DIR/*ASR*; do
  echo $i
  filename=$(basename "$i" )
  cat $i | cut -d" " -f2- | online-text-flow-events --text | sed -r '/^\s*$/d' > ${TRDIR}/${filename}
done