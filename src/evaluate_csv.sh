#!/bin/bash

cd "${0%/*}/.."

echo "name;worker;source_lang;target_lang;reference;bleu;sacrebleu" > ./evaluations/evaluations.csv
for file in `find ./evaluations -type f -name *"eval"`; do
	filename=`echo $file | awk 'BEGIN{ FS = "/"} { print $NF }'`
	worker=`echo $file | awk 'BEGIN{ FS = "/"} { print $(NF-1) }'`
	name=`echo $filename | awk 'BEGIN{ FS = "."} { print $1 } '`
	reference=`echo $filename | awk 'BEGIN{ FS = "."} { print $4 } '`
	source_lang="en"
	target_lang=${reference:2:2}
	bleu=`grep $'tot' $file | grep -w 'BLEU' | grep 'docAsAWhole' | tr -s ' ' | cut -d" " -f 4`
	sacrebleu=`grep $'tot' $file | grep -w 'sacreBLEU' | grep 'docAsAWhole' | tr -s ' ' | cut -d" " -f 4`
	echo "$name;$worker;$source_lang;$target_lang;$reference;$bleu;$sacrebleu" >> ./evaluations/evaluations.csv
done
