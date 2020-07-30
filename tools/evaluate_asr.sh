#!/bin/bash
#goes through all .ASR files and compares them with OSt files with the same name
#calculates WER, word recognition rate and sentence error rate
#see https://github.com/belambert/asr-evaluation for the 'wer' command

cd "${0%/*}/.."
root_dir="./documents"

for asr in `find $root_dir -type f -name "*.ASR*" -not -name "*eval*"`; do
	ost=`echo $asr | sed "s/ASR.*/OSt/g"` 
	ost=`echo "$ost" | awk 'BEGIN{ FS="/" } { print $NF }'`
	ost=`find . -type f -name "*$ost" -not -path "*outputs*"`
	score=`echo $asr.eval`

	echo "$asr" > $score
	echo "$ost" >> $score
	wer "$ost" "$asr" >> $score
done 
