#!/bin/bash
#list all english data related to auditing that can be used to evaluate asr (that have a recording and an OSt)

cd "${0%/*}/.."
f1=`cat ./auto-iwslt2020-consecutive | grep 'OSt\|OS.mp3\|OStt'`
f2=`cat ./auto-iwslt2020-wgvat | grep 'OSt\|OStt\|OS.mp3'`
f3=`cat ./auto-iwslt2020-wgvat | grep 'RSt\|RS.mp3'`
f4=`cat ./auto-iwslt2020-devset | grep 'OSt\|OStt\|mp3' | grep "auditing"`

files=`echo "$f1 $f2 $f3 $f4"`
./scripts/group_files.sh "$files" > auto-asr-english-auditing
