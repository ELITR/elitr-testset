#!/bin/bash

if [ $# -ne 2 ] ; then
    echo "usage: $0 <input dir with logs> <dir containing reference transcripts>"
    exit
fi

REF_DIR=$2
DIR=$1
filename=$(echo $DIR | cut -d"." -f1,2)
TRDIR="$(echo $DIR | cut -d"." -f1,2).transcript" # Transcript dir

# ASR Transcripts
for i in $DIR/*ASR*; do
  echo $i
  filename=$(basename "$i" | rev | cut -d. -f2- | rev)
  cat $i | cut -d" " -f2- | online-text-flow-events --text | sed -r '/^\s*$/d' > ${TRDIR}/${filename}
done