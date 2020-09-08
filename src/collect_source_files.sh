#!/bin/bash

'''
Search recursively for text based documents in the input dir and segregate them based on their language codes.
It further creates necessary task files thereby getting a text document ready to be translated into multiple languages 
using all available MT workers.
'''

if [ $# -ne 1 ] ; then
    echo "usage: $0 <source dir that contains all text-based translations>"
    exit
fi
source_dir=$1
#langs_set=('ar' 'az' 'be' 'bg' 'bs' 'cs' 'da' 'de' 'el' 'en' 'es' 'et' 'fi' 'fr' 'ga' 'he' 'hr' 'hu' 'hy' 'is' 'it' 'ka' 'kk' 'lb' 'lt' 'lv' 'me' 'mk' 'mt' 'nl' 'no' 'pl' 'p    t' 'ro' 'ru' 'sk' 'sl' 'sq' 'sr' 'sv' 'tr' 'uk')
langs_set=("cs" "de" "en" "es" "fr" "sk" "ru")
for k in "${langs_set[@]}"; do

  # This would find all files ending with $k and store it as an array
  files_found=()
  while IFS=  read -r -d $'\0'; do
      files_found+=("$REPLY")
  done < <(find ${source_dir} -maxdepth 20 -name "*${k}" ! -name "*ASR*" -type f -print0)

  # Get count of number of files found
  line_count=${#files_found[@]}
  echo "Total ${line_count} ${k^^} files found."

  if [[ $line_count != 0 ]] ; then
    # Select MT workers
    echo "Select MT worker(s)"
    asr=${k}-EU
    op_avail_mt_workers=$(`git rev-parse --show-toplevel`/agg-table.sh | grep '  text.* text' | grep -v 'pub' | awk -v pat="$asr" '$1 ~ pat' | awk '{print $3}')
    mt_workers=($op_avail_mt_workers)

    for i in "${!mt_workers[@]}"; do
      printf "\t%d. %s\n" "$(($i+1))" "${mt_workers[$i]}"
    done

    mt_fp="\n"
    mt_fps=""
    echo "Your choice: "
    until [ "a$mt_fp" = "a" ];do
      read mt_fp
      mt_fps=$mt_fps" "$mt_fp
    done

    # Generate flists for each of the op fingerprint selected above
    op_fp_arr=($mt_fps)
    echo "*********************"
    rm -rf only-${k}-2-${op_fp}-mt.flist     # Delete old flist
    for i in "${op_fp_arr[@]}"; do
      echo "You entered:${mt_workers[$i-1]}"
      # Creating task files for each of the found languages
      ip_fp="${k}-EU"
      op_fp=${mt_workers[$i-1]}

      for file in "${files_found[@]}"; do
        echo "./text2text.sh ${ip_fp} ${op_fp} ${file}" >> only-${k}-2-${op_fp}-mt.flist
        chmod a+x only-${k}-2-${op_fp}-mt.flist
      done
    done
  fi
done
