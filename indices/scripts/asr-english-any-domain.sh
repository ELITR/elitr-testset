#!/bin/bash
#list all data in english that can be used to evaluate asr (that have a recording and an OSt)

cd "${0%/*}/.."
f1=`cat ./auto-iwslt2020-devset ./auto-iwslt2020-consecutive ./auto-iwslt2020-antrecorp | grep 'OSt\|OS.mp3\|OStt'`
f2=`cat ./auto-iwslt2020-khanacademy | grep 'OSt\|OStt\|mkv'`
f3=`cat ./auto-iwslt2020-wgvat | grep 'OSt\|OStt\|OS.mp3'`
f4=`cat ./auto-iwslt2020-wgvat | grep 'RSt\|RS.mp3'`
f5=`cat ./auto-langtools-workshop ./auto-linguistic-mondays | grep 'OSt\|mp3'`  

files=`echo "$f1 $f2 $f3 $f4 $f5"`
./scripts/group_files.sh "$files" > auto-asr-english-any-domain
