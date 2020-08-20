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

## Re-alignment of ASR trasncript using reference OSt files
filename=$(basename $DIR | rev | cut -d. -f2- | rev)
input=$(find ${TRDIR} -maxdepth 1 -name "${filename}.ASR*" | grep -v "realg") # Get the fullpath of the ASR 'trascript' file

ASR_filename=$(basename $input)
ASR_lang=${ASR_filename:(-2)}
reference=$(echo $filename | sed 's/.OS//g' )
item=$(find ${REF_DIR}/ -maxdepth 1 -name "${reference}.OSt" |  head -1)


#echo ${item}
#echo ${ASR_lang}
#echo ${input}
#echo ${TRDIR}/${ASR_filename}.realg
./segment.sh $item ${ASR_lang} < ${input} > ${TRDIR}/${ASR_filename}.realg
