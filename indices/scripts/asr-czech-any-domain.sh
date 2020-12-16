#!/bin/bash
#list all data that can be used to evaluate czech asr (that have a recording and an OSt)

cd "${0%/*}/.."
f1=`cat ./auto-czech-asr | grep 'OSt\|mp3\|OStt'`
f2=`cat ./auto-iwslt2020-wgvat| grep 'IS'`

files=`echo "$f1 $f2"`
./scripts/group_files.sh "$files" > auto-asr-czech-any-domain
