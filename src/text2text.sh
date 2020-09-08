#!/bin/bash

'''
Generate transcripts of the text based documents as per the given MT fingerprint.
'''

if [ $# -ne 3 ] ; then
    echo "usage: $0 <ip-fingerprint> <op-fingerprint> <full path to text based translation file>"
    exit
fi

IP_FP=$1 # eg. en-EU
OP_FP=$2 # eg. rb-EU_fromEN-en_to_41
source_file=$3 # full path to text based translation file


#TRDIR=$(echo $source_file | sed 's/pvlogs/transcript/g' )
#MT_TR_DIR=${TRDIR}/${OP_FP} # Transcript dir for MT

filename=$(basename $source_file)
source_dir=$(dirname $source_file)
#input=$(find ${TRDIR} -maxdepth 1 -name "${filename}.ASR*") # Get the fullpath of the ASR 'trascript' file
output_dir=$(echo ${source_dir} | sed 's/documents/logs/g')

mkdir -p ${output_dir}/${OP_FP}/${filename}.pvlogs/
mkdir -p ${output_dir}/${OP_FP}/${filename}.transcripts/
#mkdir -p ${MT_TR_DIR} ${source_file}/${OP_FP}
MT_TR_DIR=${output_dir}/${OP_FP}/${filename}.transcripts/

# creating pvconfig
echo "SRCLANG=${IP_FP}" > ${output_dir}/${OP_FP}/${filename}.pvlogs/pvconfig
echo "ASR Worker=${OP_FP}" >> ${output_dir}/${OP_FP}/${filename}.pvlogs/pvconfig

output_file=${output_dir}/${OP_FP}/${filename}.pvlogs/${filename}.MT${OP_FP:0:2}

stdbuf -oL ./textclient -p 4448 -f ${IP_FP} -i ${OP_FP} < ${source_file} > $output_file

# Generate readable transcripts for the above translations made
if [[ $OP_FP == *"rb"* ]]; then
  ## Works only for rainbow workers
  IFS=''
  while read line; do
    num_fields=$(echo $line |  awk -F"\t" '{print NF}')
    num_langs=$((num_fields / 2))

    for ((i=1; i<=num_langs; i++)); do
      lang=$(echo $line | cut -d$'\t' -f$(((2 * i) - 1)))
      text=$(echo $line | cut -d$'\t' -f$((2 * i)))

  #    echo $lang
  #    echo $text
      echo $text >> ${MT_TR_DIR}/${filename}.MT${lang}
    done
  done < "$output_file"
else

  lang=${OP_FP:0:2}
  cp -- ${output_file} ${MT_TR_DIR}/${filename}.MT${lang}
fi

# No-Re-alignment needed.
