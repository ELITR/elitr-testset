#!/bin/bash

'''
Generate translations of given text document into all available languages.
'''

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
input=$(find ${TRDIR} -maxdepth 1 -name "${filename}.ASR*" | grep -v "realg") # Get the fullpath of the ASR 'trascript' file
output_file=${pvlogs_path}/${OP_FP}/${filename}.MT${OP_FP:0:2}

mkdir -p ${MT_TR_DIR} ${pvlogs_path}/${OP_FP}


## Re-alignment of ASR trasncript using reference OSt files
ASR_filename=$(basename $input)
ASR_lang=${ASR_filename:(-2)}
reference=$(echo $filename | sed 's/.OS//g' )
item=$(find ${REF_DIR}/ -maxdepth 1 -name "${reference}.OSt" |  head -1)

#echo ${item}
#echo ${ASR_lang}
#echo ${input}
#echo ${TRDIR}/${ASR_filename}.realg
#./segment.sh $item ${ASR_lang} < ${input} > ${TRDIR}/${ASR_filename}.realg


# creating pvconfig
echo "SRCLANG=${IP_FP}" > ${pvlogs_path}/${OP_FP}/pvconfig
echo "ASR Worker=${OP_FP}" >> ${pvlogs_path}/${OP_FP}/pvconfig
echo " Input=$input"
#stdbuf -oL ./textclient -p 4448 -f ${IP_FP} -i ${OP_FP} < $input > $output_file

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
      echo $text >> ${MT_TR_DIR}/${filename}.MT${lang}
    done
  done < "$output_file"
else

  lang=${OP_FP:0:2}
  cp -- ${output_file} ${MT_TR_DIR}/${filename}.MT${lang}
fi

# Re-alignment of MT trasncript generated above using reference translations
for i in ${MT_TR_DIR}/*MT*; do
  filename=$(basename "$i" | rev | cut -d. -f2- | rev)
  lang=$( echo $i | rev | cut -d"." -f1 | rev | sed 's/MT//g')
  reference=$(echo $filename | sed 's/.OS//g' )

#  echo $filename
#  echo $lang
#  echo $reference

  if [[ ${i} != *".realg"* ]] ; then # We dont want to re-align files which has already been re-aligned
    # This would search for the above filename's reference translation
    item=$(find ${REF_DIR}/ -maxdepth 1 -name "*${reference}*" | grep "TT${lang}" | head -1)
#    echo "Item found = $item"
    # Excute below only if find returns a valid file

    if [[ ${item:(-2)} == ${lang} ]] ; then
      ./segment.sh $item ${lang} < $i > ${MT_TR_DIR}/${filename}.MT${lang}.realg
    fi
  fi

done
