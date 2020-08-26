#!/bin/bash
#list all data in english that can be used to evaluate asr (that have a recording and an OSt)

cd "${0%/*}/.."
f1=`cat ./iwslt-devset ./iwslt-consecutive ./iwslt-antrecorp | grep 'OSt\|OS.mp3\|OStt'`
f2=`cat ./iwslt-khanacademy | grep 'OSt\|OStt\|mkv'`
f3=`cat ./iwslt-wgvat | grep 'OSt\|OStt\|OS.mp3'`
f4=`cat ./iwslt-wgvat | grep 'RSt\|RS.mp3'`
f5=`cat ./langtools-workshop ./linguistic-mondays | grep 'OSt\|mp3'`  

files=`echo "$f1 $f2 $f3 $f4 $f5"`
./scripts/group_files.sh "$files" > asr-english-any-domain
