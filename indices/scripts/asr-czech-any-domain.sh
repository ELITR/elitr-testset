#!/bin/bash
#list all data that can be used to evaluate czech asr (that have a recording and an OSt)

cd "${0%/*}/.."
f1=`cat ./czech-asr | grep 'OSt\|mp3\|OStt'`
f2=`cat ./iwslt-wgvat| grep 'IS'`

files=`echo "$f1 $f2"`
./scripts/group_files.sh "$files" > asr-czech-any-domain
