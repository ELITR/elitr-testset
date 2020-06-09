#!/bin/bash

rm ./iwslt-devset
root_dir='../documents/iwslt2020-nonnative-slt/devset'

for ost in `ls $root_dir/*.OSt`; do #everything has an OSt
  echo $ost >> ./iwslt-devset

  mp3=`echo $ost | sed 's/OSt/mp3/g'`
  ls $mp3 2>/dev/null >> ./iwslt-devset

  os_mp3=`echo $ost | sed 's/OSt/OS.mp3/g'`
  ls $os_mp3 2>/dev/null >> ./iwslt-devset

  ttcs=`echo $ost | sed 's/OSt/TTcs/g'`
  ls $ttcs 2>/dev/null >> ./iwslt-devset

  ttcs1=`echo $ost | sed 's/OSt/TTcs1/g'`
  ls $ttcs1 2>/dev/null >> ./iwslt-devset

  ttcs2=`echo $ost | sed 's/OSt/TTcs2/g'`
  ls $ttcs2 2>/dev/null >> ./iwslt-devset

  ttde=`echo $ost | sed 's/OSt/TTde/g'`
  ls $ttde 2>/dev/null >> ./iwslt-devset

  # ../path_to_file/output_filename.json
  name=`echo "${ost}" | cut -d"/" -f 5` #name of the file
  path=`echo "${ost}" | cut -d"/" -f 1-4` #path to the file
  output=`echo "${path}/output_${name}" | sed 's/OSt/json/g'`
  ls $output 2>/dev/null >> ./iwslt-devset

  echo "" >> ./iwslt-devset
done
