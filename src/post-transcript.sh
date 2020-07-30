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
  filename=$(basename "$i" | cut -d. -f1,2,3)
  cat $i | cut -d" " -f2- | online-text-flow-events --text | sed -r '/^\s*$/d' > ${TRDIR}/${filename}
done


# MT Transcripts
for i in $DIR/*MT*; do
  echo "#########"
  filename=$(basename "$i" | cut -d. -f1,2,3)
  python final.py < $i | cut -d" " -f3- > ${TRDIR}/${filename}.temp

  input=${TRDIR}/${filename}.temp
  output=${TRDIR}/${filename}


  lang="$(echo $filename | cut -d"." -f3)"
  reference="$(echo $filename | cut -d"." -f1,2 | sed 's/_16K//g' )".TT"${lang:2:4}"
  echo $reference
  # searching for this refernece file in the original dir


  for item in $REF_DIR/*"${reference}"*; do
    echo $item
    echo $input
    ./segment.sh $item ${lang:2:4} < $input > $output
    echo "#########"
  done

  if [ -f "${TRDIR}/${filename}.temp" ]; then
    rm -rf ${TRDIR}/${filename}.temp
  fi
done