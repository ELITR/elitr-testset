#!/bin/bash

if [ $# -ne 4 ] ; then
    echo "usage: $0 <ip-fingerprint> <op-fingerprint> <input dir with logs> <dir containing reference transcripts>"
    exit
fi

IP_FP=$1 # eg. en-EU
OP_FP=$2 # eg. rb-EU_fromEN-en_to_41
pvlogs_path=$3 # input dir with logs eg. elitr-testset/logs/iwslt2020-nonnative-slt/testset/antrecorp/en-EU-ufal-da-20200120/03_botel-proti-proudu.OS_16K.pvlogs
REF_DIR=$4 # Path containing the reference transcripts

TRDIR=$(echo $pvlogs_path | sed 's/pvlogs/transcript/g' )
MT_TR_DIR=${TRDIR}/${OP_FP} # Transcript dir for MT

filename=$(basename $pvlogs_path | rev | cut -d. -f2- | rev)
input=$(find ${TRDIR} -name "${filename}.ASR*") # Get the fullpath of the ASR trascript file

output_file=${pvlogs_path}/${OP_FP}/${filename}.MTrb

mkdir -p ${MT_TR_DIR} ${pvlogs_path}


stdbuf -oL ./textclient -p 4448 -f ${IP_FP} -i ${OP_FP} < $input > $output_file

# Generate readable transcripts for the above translations made
if [[ $OP_FP == *"rb-EU"* ]]; then
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
      echo $text >> ${MT_TR_DIR}/${filename}.tempMT${lang}
    done
  done < "$output_file"
else

  lang=${OP_FP:0:2}
  cp -- ${output_file} ${MT_TR_DIR}/${filename}.tempMT${lang}
fi

# Re-alignment of MT trasncript generated above using reference translations
for i in ${MT_TR_DIR}/*MT*; do
  filename=$(basename "$i" | rev | cut -d. -f2- | rev)
  lang=$( echo $i | rev | cut -d"." -f1 | rev | sed 's/MT//g' | sed 's/temp//g' )
  reference=$(echo $filename | sed 's/.OS_16K//g' ).TT${lang}
  
  # This loop would search for the above filename's reference translation
  for item in $REF_DIR/*"${reference}"*; do
      echo $item
      echo $i
      ./segment.sh $item ${lang} < $i > ${MT_TR_DIR}/${filename}.MT${lang}
  done
done